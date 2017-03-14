require 'httparty'

class WeatherReport
  include HTTParty

  attr_accessor :zip, :city, :state, :obs_time, :temperature, :weather, :rain_last_hr, :rain_today, :wind, :error

  def initialize(zip, city=nil, state=nil, obs_time=nil, temperature=nil, weather=nil, rain_last_hr=nil, rain_today=nil, wind=nil, error=nil)
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

  def zip
    @zip
  end

  def city
    @city
  end

  def state
    @state
  end

  def obs_time
    @obs_time
  end

  def temperature
    @temperature
  end

  def weather
    @weather
  end

  def rain_last_hr
    @rain_last_hr
  end

  def rain_today
    @rain_today
  end

  def wind
    @wind
  end

  def error
    @error
  end

  def rain_sentence
    if rain_last_hr.to_f == 0 and rain_today.to_f > 0
      " There is no precipitation right now, but there has been a total of #{rain_today} in. today."
    elsif rain_last_hr.to_f > 0 and rain_today.to_f > 0
      " There has been #{rain_last_hr} in. of precipitation in the last hour for a total of #{rain_today} in. for the day."
    elsif rain_today.to_f > 0
      " There has been #{rain_today} in. of precipitation today."
    end
  end

  def narrative
    "Weather Report for #{city}, #{state} #{zip} (#{obs_time}):\nConditions are #{weather.downcase}, with a current temperature of #{temperature}.#{rain_sentence} Winds are #{wind.downcase}."
  end

  def self.find(zip)
    key = ENV["WU_KEY"]
    response = get("http://api.wunderground.com/api/#{key}/conditions/q/#{zip}.json")
    if response.success?
      current_observation = response["current_observation"]
      if current_observation.nil?
        self.new(zip, nil, nil, nil, nil, nil, nil, nil, nil,
          response["response"]["error"]["description"])
      else
      self.new(zip, current_observation["display_location"]["city"],
        current_observation["display_location"]["state"],
        current_observation["observation_time"],
        current_observation["temperature_string"],
        current_observation["weather"], current_observation["precip_1hr_in"],
        current_observation["precip_today_in"],
        current_observation["wind_string"], nil)
      end
    else
      raise response.response
    end
  end
end
