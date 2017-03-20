module Narrative
  extend self

  def rain_sentence(data)
    if data.rain_last_hr.to_f == 0 and data.rain_today.to_f > 0
      " There is no precipitation right now, but there has been a total of #{data.rain_today} in. today."
    elsif data.rain_last_hr.to_f > 0 and data.rain_today.to_f > 0
      " There has been #{data.rain_last_hr} in. of precipitation in the last hour for a total of #{data.rain_today} in. for the day."
    elsif data.rain_today.to_f > 0
      " There has been #{data.rain_today} in. of precipitation today."
    end
  end

  def content(data)
    "Weather Report for #{data.city}, #{data.state} #{data.zip} (#{data.obs_time}):\nConditions are #{data.weather.downcase}, with a current temperature of #{data.temperature}.#{rain_sentence(data)} Winds are #{data.wind.downcase}."
  end
end
