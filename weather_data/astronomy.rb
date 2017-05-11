require 'httparty'
require_relative './base.rb'

module WeatherData
  class Astronomy < Base
    include HTTParty
    API_ENDPOINT = 'astronomy'
    DATA_POINTS = [:city, :state, :sunrise_hr, :sunrise_min, :sunset_hr, :sunset_min]
    attr_accessor(*DATA_POINTS) #splat operator

    def narrative
      "\nSunrise and Sunset Times for #{city}, #{state}:\n\nThe sunrise time is projected to be #{sunrise_hr}:#{sunrise_min}, and sunset is projected at #{sunset_hr}:#{sunset_min}"
    end

    def set_data_points(response)
      if moonphase = response["moon_phase"]
        geoinfo = self.class.get("http://api.wunderground.com/api/#{ENV["WU_KEY"]}/geolookup/q/#{zip}.json")
          self.city = geoinfo["location"]["city"]
          self.state = geoinfo["location"]["state"]
          self.sunrise_hr = moonphase["sunrise"]["hour"]
          self.sunrise_min = moonphase["sunrise"]["minute"]
          self.sunset_hr = moonphase["sunset"]["hour"]
          self.sunset_min = moonphase["sunset"]["minute"]
      else
        self.error = response["response"]["error"]["description"]
      end
    end
  end
end
