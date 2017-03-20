require './weather_report.rb'

puts 'Enter a five-digit zip code to get a report of current weather conditions in that area. Enter "0" if you want to quit'
zip = gets.chomp

response = WeatherReport.find(zip)
attempts = 1

while (attempts <= 3 and zip != "0") do
  if zip == "0"
    "Goodbye!"
    break
  elsif not response.error.nil? and attempts < 3
    puts "Sorry: #{response.error}."
    puts "Enter another five-digit zip code. Or, press '0' to exit"
    zip = gets.chomp
    response = WeatherReport.find(zip)
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
