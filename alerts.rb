require 'httparty'
require './narrative.rb'

class Alerts
  include HTTParty

  attr_accessor :zip, :city, :state, :alert_count, :top_alert_type, :top_alert_message, :error

  def initialize(zip, city: nil, state: nil, alert_count: nil, top_alert_type: nil, top_alert_message: nil, error: nil)
    self.zip = zip
    self.city = city
    self.state = state
    self.alert_count = alert_count
    self.top_alert_type = top_alert_type
    self.top_alert_message = top_alert_message
    self.error = error
  end

  def narrative
    Narrative.alerts(self)
  end

  def self.weather_report_data(response, zip)
    alerts = response["alerts"]
    geoinfo = get("http://api.wunderground.com/api/#{ENV["WU_KEY"]}/geolookup/q/#{zip}.json")
    if alerts
      if alerts.count > 0
        {
          city: geoinfo["location"]["city"],
          state: geoinfo["location"]["state"],
          alert_count: alerts.count,
          top_alert_type: alerts[0]["description"],
          top_alert_message: alerts[0]["message"]
        }
      elsif alerts.count == 0
        {
          city: geoinfo["location"]["city"],
          state: geoinfo["location"]["state"],
          alert_count: alerts.count
        }
      end
    else
      {error: response["response"]["error"]["description"]}
    end
  end

  def self.find(zip)
    key = ENV["WU_KEY"]
    response = get("http://api.wunderground.com/api/#{key}/alerts/q/#{zip}.json")
    if response.success?
      self.new(zip, weather_report_data(response, zip))
    else
      raise response.response
    end
  end
end
