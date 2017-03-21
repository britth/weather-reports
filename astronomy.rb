require 'httparty'
require './narrative.rb'

class Astronomy
  include HTTParty

  attr_accessor :zip, :city, :state, :sunrise_hr, :sunrise_min, :sunset_hr, :sunset_min, :error

  def initialize(zip, city: nil, state: nil, sunrise_hr: nil, sunrise_min: nil, sunset_hr: nil, sunset_min: nil, error: nil)
    self.zip = zip
    self.city = city
    self.state = state
    self.sunrise_hr = sunrise_hr
    self.sunrise_min = sunrise_min
    self.sunset_hr = sunset_hr
    self.sunset_min = sunset_min
    self.error = error
  end

  def narrative
    Narrative.astronomy(self)
  end

  def self.weather_report_data(response, zip)
    if moonphase = response["moon_phase"]
      geoinfo = get("http://api.wunderground.com/api/#{ENV["WU_KEY"]}/geolookup/q/#{zip}.json")
      {
        city: geoinfo["location"]["city"],
        state: geoinfo["location"]["state"],
        sunrise_hr: moonphase["sunrise"]["hour"],
        sunrise_min: moonphase["sunrise"]["minute"],
        sunset_hr: moonphase["sunset"]["hour"],
        sunset_min: moonphase["sunset"]["minute"]
      }
    else
      {error: response["response"]["error"]["description"]}
    end
  end

  def self.find(zip)
    key = ENV["WU_KEY"]
    response = get("http://api.wunderground.com/api/#{key}/astronomy/q/#{zip}.json")
    if response.success?
      self.new(zip, weather_report_data(response, zip))
    else
      raise response.response
    end
  end
end
