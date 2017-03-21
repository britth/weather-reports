require './current_weather.rb'
require './ten_day_forecast.rb'
require './astronomy.rb'
require './alerts.rb'

class WeatherReportMain

  def zipcode(type)
    puts "Enter a five-digit zip code to get a #{type} in that area. Enter \"0\" to go back to the main menu"
    gets.chomp
  end

  def current
    zip = zipcode("report of current weather conditions")
    response = CurrentWeather.find(zip)
    attempts = 1

    while (attempts <= 3 and zip != "0") do
      if zip == "0"
        break
      elsif not response.error.nil? and attempts < 3
        puts "Sorry: #{response.error}."
        puts "Enter another five-digit zip code. Or, press '0' to exit"
        zip = gets.chomp
        response = CurrentWeather.find(zip)
        attempts += 1
        #puts response.error
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

  def ten_day
    zip = zipcode("10-Day weather forecast")
    response = TenDayForecast.find(zip)
    attempts = 1

    while (attempts <= 3 and zip != "0") do
      if zip == "0"
        "Goodbye!"
        break
      elsif not response.error.nil? and attempts < 3
        puts "Sorry: #{response.error}."
        puts "Enter another five-digit zip code. Or, press '0' to exit"
        zip = gets.chomp
        response = TenDayForecast.find(zip)
        attempts += 1
        #puts response.error
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

  def astronomy
    zip = zipcode("projection of sunrise and sunset times")
    response = Astronomy.find(zip)
    attempts = 1

    while (attempts <= 3 and zip != "0") do
      if zip == "0"
        "Goodbye!"
        break
      elsif not response.error.nil? and attempts < 3
        puts "Sorry: #{response.error}."
        puts "Enter another five-digit zip code. Or, press '0' to exit"
        zip = gets.chomp
        response = Astronomy.find(zip)
        attempts += 1
        #puts response.error
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

  def alerts
    zip = zipcode("list of active alerts")
    response = Alerts.find(zip)
    attempts = 1

    while (attempts <= 3 and zip != "0") do
      if zip == "0"
        "Goodbye!"
        break
      elsif not response.error.nil? and attempts < 3
        puts "Sorry: #{response.error}."
        puts "Enter another five-digit zip code. Or, press '0' to exit"
        zip = gets.chomp
        response = Alerts.find(zip)
        attempts += 1
        #puts response.error
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
    puts "Welcome! Enter \"1\" if you want information on current conditions. Enter \"2\" if you want a 10-day forecast. Enter \"3\" if you want to know the projected sunrise and sunset times for a location. Enter \"4\" if you want a list of active alerts. If you'd like to quit, enter \"0\"."
    gets.chomp
  end

  def report_type_next
    puts "\nEnter \"1\" if you want information on current conditions, Enter \"2\" if you want a 10-day forecast. Enter \"3\" if you want to know the project sunrise and sunset times for a location. Enter \"4\" if you want a list of active alerts. If you'd like to quit, enter \"0\"."
    gets.chomp
  end

  def request_weather_reports
    report_type = report_type_start
    attempts = 0
    while attempts <= 3
      # and ((report_type == "0" or report_type == "1" or report_type == "2") or (report_type != "0" and report_type != "1" and report_type != "2"))
      if attempts == 3
        puts "You've made too many requests. Come back later."
        attempts += 1
        break
      elsif report_type != "0" and report_type != "1" and report_type != "2" and report_type != "3" and report_type != "4"
        puts "That's not a valid request. Enter \"1\" for current conditions, \"2\" for a 10-day forecast, or \"0\" to quit"
        attempts += 1
        report_type = gets.chomp
      elsif report_type == "0"
        puts "Thank you!"
        break
      elsif report_type == "1"
        current_calls = current
        attempts += current_calls
        report_type = report_type_next
      elsif report_type == "2"
        ten_day_calls = ten_day
        attempts += ten_day_calls
        report_type = report_type_next
      elsif report_type == "3"
        astronomy_calls = astronomy
        attempts += astronomy_calls
        report_type = report_type_next
      elsif report_type == "4"
        alerts_calls = alerts
        attempts += alerts_calls
        report_type = report_type_next
      end
    end
  end
end

weather_report = WeatherReportMain.new
weather_report.request_weather_reports
