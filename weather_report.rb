require 'httparty'
require './narrative.rb'

class WeatherReport
  include HTTParty

  attr_accessor :zip, :city, :state, :obs_time, :temperature, :weather, :rain_last_hr, :rain_today, :wind, :error

  def initialize(zip, city: nil, state: nil, obs_time: nil, temperature: nil, weather: nil, rain_last_hr: nil, rain_today: nil, wind: nil, error: nil)
    self.zip = zip
    self.city = city
    self.state = state
    self.obs_time = obs_time
    self.temperature = temperature
    self.weather = weather
    self.rain_last_hr = rain_last_hr
    self.rain_today = rain_today
    self.wind = wind
    self.error = error
  end

  def narrative
    Narrative.content(self)
  end

  def self.weather_report_data(response)
    if current_observation = response["current_observation"]
      {
        city: current_observation["display_location"]["city"],
        state: current_observation["display_location"]["state"],
        obs_time: current_observation["observation_time"],
        temperature: current_observation["temperature_string"],
        weather: current_observation["weather"],
        rain_last_hr: current_observation["precip_1hr_in"],
        rain_today: current_observation["precip_today_in"],
        wind: current_observation["wind_string"]
      }
    else
      {error: response["response"]["error"]["description"]}
    end
  end

  def self.find(zip)
    key = ENV["WU_KEY"]
    response = get("http://api.wunderground.com/api/#{key}/conditions/q/#{zip}.json")
    if response.success?
      self.new(zip, weather_report_data(response))
    else
      raise response.response
    end
  end

  def as_json(options={})
    {
      zip: zip,
      city: city,
      state: state,
      obs_time: obs_time,
      temperature: temperature,
      weather: weather,
      rain_last_hr: rain_last_hr.to_f,
      rain_today: rain_today.to_f,
      wind: wind,
      error: error.to_s
    }
  end
end
