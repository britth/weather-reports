require './weather_report.rb'

puts 'Enter a five-digit zip code to get a report of current weather conditions in that area'
zip = gets.chomp
puts "Entered #{zip}"

report = WeatherReport.find(zip)
puts report.narrative
