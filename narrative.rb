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

  def current(data)
    "\nWeather Report for #{data.city}, #{data.state} #{data.zip} (#{data.obs_time}):\nConditions are #{data.weather.downcase}, with a current temperature of #{data.temperature}.#{rain_sentence(data)} Winds are #{data.wind.downcase}."
  end

  def ten_day(data)
    "\n10 Day Forecast for #{data.city}, #{data.state} (As of #{data.date}):\n\n#{data.period_1_day}: #{data.period_1_forecast}\n#{data.period_2_day}: #{data.period_2_forecast}\n#{data.period_3_day}: #{data.period_3_forecast}\n#{data.period_4_day}: #{data.period_4_forecast}\n#{data.period_5_day}: #{data.period_5_forecast}\n#{data.period_6_day}: #{data.period_6_forecast}\n#{data.period_7_day}: #{data.period_7_forecast}\n#{data.period_8_day}: #{data.period_8_forecast}\n#{data.period_9_day}: #{data.period_9_forecast}\n#{data.period_10_day}: #{data.period_10_forecast}"
  end

  def astronomy(data)
    "\nSunrise and Sunset Times for #{data.city}, #{data.state}:\n\nThe sunrise time is projected to be #{data.sunrise_hr}:#{data.sunrise_min}, and sunset is projected at #{data.sunset_hr}:#{data.sunset_min}"
  end

  def alerts(data)
    puts "\nCurrent alerts for #{data.city}, #{data.state}"
    if data.alert_count == 0
      puts "There are no alerts to report."
    elsif data.alert_count > 0
      puts "There are currently #{data.alert_count} alerts to report, including a #{data.top_alert_type} (#{data.top_alert_message})."
    end
  end

  def hurricanes(data)
    puts "Active Hurricanes"
    if data.hurricanes.count == 0
      puts "There are no hurricanes to report."
    elsif data.hurricanes.count > 0
      puts "There are currently #{data.hurricanes.count} active hurricanes: #{hurricanes}"
    end
  end
end
