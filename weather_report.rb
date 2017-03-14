require 'httparty'

class WeatherReport
  include HTTParty

  attr_accessor :city, :state, :obs_time, :temperature, :weather, :rain_last_hr, :rain_today

  def initialize(city, state, obs_time, temperature, weather, rain_last_hr, rain_today)
    self.city = city
    self.state = state
    self.obs_time = obs_time
    self.temperature = temperature
    self.weather = weather
    self.rain_last_hr = rain_last_hr
    self.rain_today = rain_today
  end

  def narrative
    "Weather report for #{@city}, #{@state} (#{@obs_time}):\nConditions are #{@weather.downcase}, with a current temperature of #{@temperature}. There has been #{@rain_last_hr} of precipation in the last hour for a total of #{@rain_today} for the day."
  end

  def self.find(zip)
    key = ENV["WU_KEY"]
    response = get("http://api.wunderground.com/api/#{key}/conditions/q/#{zip}.json")
    if response.success?
      current_observation = response["current_observation"]
      self.new(current_observation["display_location"]["city"], current_observation["display_location"]["state"], current_observation["observation_time"],
         current_observation["temperature_string"], current_observation["weather"], current_observation["precip_1hr_string"], current_observation["precip_today_string"])
    else
      raise response.response
    end
  end
end

# response = {"response"=>{"version"=>"0.1", "termsofService"=>"http://www.wunderground.com/weather/api/d/terms.html", "features"=>{"conditions"=>1}}, "current_observation"=>{"image"=>{"url"=>"http://icons.wxug.com/graphics/wu2/logo_130x80.png", "title"=>"Weather Underground", "link"=>"http://www.wunderground.com"}, "display_location"=>{"full"=>"Durham, NC", "city"=>"Durham", "state"=>"NC", "state_name"=>"North Carolina", "country"=>"US", "country_iso3166"=>"US", "zip"=>"27713", "magic"=>"1", "wmo"=>"99999", "latitude"=>"35.91999817", "longitude"=>"-78.91999817", "elevation"=>"105.2"}, "observation_location"=>{"full"=>"Woodcroft, Durham, North Carolina", "city"=>"Woodcroft, Durham", "state"=>"North Carolina", "country"=>"US", "country_iso3166"=>"US", "latitude"=>"35.924587", "longitude"=>"-78.946289", "elevation"=>"302 ft"}, "estimated"=>{}, "station_id"=>"KNCDURHA132", "observation_time"=>"Last Updated on March 14, 12:46 PM EDT", "observation_time_rfc822"=>"Tue, 14 Mar 2017 12:46:10 -0400", "observation_epoch"=>"1489509970", "local_time_rfc822"=>"Tue, 14 Mar 2017 12:46:12 -0400", "local_epoch"=>"1489509972", "local_tz_short"=>"EDT", "local_tz_long"=>"America/New_York", "local_tz_offset"=>"-0400", "weather"=>"Mostly Cloudy", "temperature_string"=>"48.6 F (9.2 C)", "temp_f"=>48.6, "temp_c"=>9.2, "relative_humidity"=>"77%", "wind_string"=>"From the West at 1.3 MPH Gusting to 2.7 MPH", "wind_dir"=>"West", "wind_degrees"=>264, "wind_mph"=>1.3, "wind_gust_mph"=>"2.7", "wind_kph"=>2.1, "wind_gust_kph"=>"4.3", "pressure_mb"=>"1006", "pressure_in"=>"29.70", "pressure_trend"=>"+", "dewpoint_string"=>"42 F (5 C)", "dewpoint_f"=>42, "dewpoint_c"=>5, "heat_index_string"=>"NA", "heat_index_f"=>"NA", "heat_index_c"=>"NA", "windchill_string"=>"49 F (9 C)", "windchill_f"=>"49", "windchill_c"=>"9", "feelslike_string"=>"49 F (9 C)", "feelslike_f"=>"49", "feelslike_c"=>"9", "visibility_mi"=>"10.0", "visibility_km"=>"16.1", "solarradiation"=>"--", "UV"=>"4", "precip_1hr_string"=>"0.00 in ( 0 mm)", "precip_1hr_in"=>"0.00", "precip_1hr_metric"=>" 0", "precip_today_string"=>"0.20 in (5 mm)", "precip_today_in"=>"0.20", "precip_today_metric"=>"5", "icon"=>"mostlycloudy", "icon_url"=>"http://icons.wxug.com/i/c/k/mostlycloudy.gif", "forecast_url"=>"http://www.wunderground.com/US/NC/Durham.html", "history_url"=>"http://www.wunderground.com/weatherstation/WXDailyHistory.asp?ID=KNCDURHA132", "ob_url"=>"http://www.wunderground.com/cgi-bin/findweather/getForecast?query=35.924587,-78.946289", "nowcast"=>""}}
#puts response["display_location"].city
