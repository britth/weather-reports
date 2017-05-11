require 'httparty'
require_relative './base.rb'

module WeatherData
  class CurrentWeather < Base
    include HTTParty

    API_ENDPOINT = 'conditions'
    DATA_POINTS = [:city, :state, :obs_time, :temperature, :weather, :rain_last_hr, :rain_today, :wind]
    attr_accessor(*DATA_POINTS) #splat operator

    def narrative
      "\nWeather Report for #{city}, #{state} #{zip} (#{obs_time}):\nConditions are #{weather.downcase}, with a current temperature of #{temperature}.#{rain_sentence} Winds are #{wind.downcase}."
    end

    def set_data_points(response) #todo extract this method into base class
      if current_observation = response["current_observation"]
        self.city = current_observation["display_location"]["city"]
        self.state = current_observation["display_location"]["state"]
        self.obs_time = current_observation["observation_time"]
        self.temperature = current_observation["temperature_string"]
        self.weather = current_observation["weather"]
        self.rain_last_hr = current_observation["precip_1hr_in"]
        self.rain_today = current_observation["precip_today_in"]
        self.wind = current_observation["wind_string"]
      else
        self.error = response["response"]["error"]["description"]
      end
    end

    private def rain_sentence
      if rain_last_hr.to_f == 0 and rain_today.to_f > 0
        " There is no precipitation right now, but there has been a total of #{rain_today} in. today."
      elsif rain_last_hr.to_f > 0 and rain_today.to_f > 0
        " There has been #{rain_last_hr} in. of precipitation in the last hour for a total of #{rain_today} in. for the day."
      elsif rain_today.to_f > 0
        " There has been #{rain_today} in. of precipitation today."
      end
    end
  end
end
