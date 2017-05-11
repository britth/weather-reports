require_relative 'weather_data/current_weather'
require_relative 'weather_data/ten_day_forecast'
require_relative 'weather_data/astronomy'
require_relative 'weather_data/alert'
require_relative 'weather_data/current_hurricane'
require 'byebug'

class WeatherReportMain

  def zipcode(type)
    puts "Enter a five-digit zip code to get a #{type} in that area. Enter \"0\" to go back to the main menu"
    gets.chomp
  end

  def specific_report_type(text, reportClass)
    zip = zipcode(text)
    response = reportClass.find(zip)
    attempts = 1

    while attempts <= 3 do
      if zip == "0"
        break
      elsif not response.error.nil? and attempts < 3
        puts "Sorry: #{response.error}."
        puts "Enter another five-digit zip code. Or, press '0' to exit"
        zip = gets.chomp
        response = reportClass.find(zip)
        attempts += 1
      elsif not response.error.nil? and attempts == 3
        puts "Sorry: #{response.error}. Try again in a few minutes."
        attempts += 1
      else
        puts response.narrative
        break
      end
    end
    attempts
  end

  def report_type_start
    puts "Welcome!\nEnter \"1\" if you want information on current conditions\nEnter \"2\" if you want a 10-day forecast\nEnter \"3\" if you want to know the projected sunrise and sunset times for a location\nEnter \"4\" if you want a list of active alerts\nEnter \"5\" if you want a list of active hurricanes\nEnter \"0\" to quit"
    gets.chomp
  end

  def report_type_next
    puts "\nEnter \"1\" if you want information on current conditions\nEnter \"2\" if you want a 10-day forecast\nEnter \"3\" if you want to know the project sunrise and sunset times for a location\nEnter \"4\" if you want a list of active alerts\nEnter \"5\" if you want a list of active hurricanes\nEnter \"0\" to quit"
    gets.chomp
  end

  def request_limit(attempts)
    next_request = "0"
    if attempts < 3
      next_request = report_type_next
    end
    next_request
  end

  def request_weather_reports
    report_type = report_type_start
    attempts = 0
    while attempts <= 3
      if attempts == 3
        puts "We can't handle any more requests right now. Come back later!"
        attempts += 1
        break
      elsif report_type == "0"
        puts "Goodbye!"
        break
      elsif report_type != "0" and report_type != "1" and report_type != "2" and report_type != "3" and report_type != "4" and report_type != "5"
        puts "That's not a valid request. Enter \"1\" for current conditions, \"2\" for a 10-day forecast, \"3\" for sunrise/sunset times, \"4\" for active alerts, \"5\" for active hurricanes, or \"0\" to quit"
        report_type = request_limit(attempts)
      elsif report_type == "1"
        current_calls = specific_report_type("report of current weather conditions", WeatherData::CurrentWeather)
        attempts += current_calls
        report_type = request_limit(attempts)
      elsif report_type == "2"
        ten_day_calls = specific_report_type("10-Day weather forecast", WeatherData::TenDayForecast)
        attempts += ten_day_calls
        report_type = request_limit(attempts)
      elsif report_type == "3"
        astronomy_calls = specific_report_type("projection of sunrise and sunset times", WeatherData::Astronomy)
        attempts += astronomy_calls
        report_type = request_limit(attempts)
      elsif report_type == "4"
        alert_calls = specific_report_type("list of active alerts", WeatherData::Alert)
        attempts += alert_calls
        report_type = request_limit(attempts)
      elsif report_type == "5"
        WeatherData::CurrentHurricane.new.narrative
        attempts += 1
        report_type = request_limit(attempts)
      end
    end
  end
end
