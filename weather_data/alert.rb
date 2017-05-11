require 'httparty'
require_relative './base.rb'

module WeatherData
  class Alert < Base
    include HTTParty
    API_ENDPOINT = 'alerts'
    DATA_POINTS = [:city, :state, :alert_count, :top_alert_type, :top_alert_message]
    attr_accessor(*DATA_POINTS) #splat operator

    def narrative
      puts "\nCurrent alerts for #{city}, #{state}"
      if alert_count == 0
        puts "There are no alerts to report."
      elsif alert_count > 0
        puts "There are currently #{alert_count} alerts to report, including a #{top_alert_type} (#{top_alert_message})."
      end
    end

    def set_data_points(response)
      alerts = response["alerts"]
      geoinfo = self.class.get("http://api.wunderground.com/api/#{ENV["WU_KEY"]}/geolookup/q/#{zip}.json")
      if alerts
        if alerts.count > 0
          self.city = geoinfo["location"]["city"]
          self.state = geoinfo["location"]["state"]
          self.alert_count = alerts.count
          self.top_alert_type = alerts[0]["description"]
          self.top_alert_message = alerts[0]["message"]
        elsif alerts.count == 0
          self.city = geoinfo["location"]["city"]
          self.state = geoinfo["location"]["state"]
          self.alert_count = alerts.count
        end
      else
        self.error = response["response"]["error"]["description"]
      end
    end
  end
end
