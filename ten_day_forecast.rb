require 'httparty'
require_relative './narrative.rb'

class TenDayForecast
  include HTTParty

  attr_accessor :zip, :date, :city, :state, :period_1_day, :period_1_forecast, :period_2_day, :period_2_forecast, :period_3_day, :period_3_forecast, :period_4_day, :period_4_forecast, :period_5_day, :period_5_forecast, :period_6_day, :period_6_forecast, :period_7_day, :period_7_forecast, :period_8_day, :period_8_forecast, :period_9_day, :period_9_forecast, :period_10_day, :period_10_forecast, :error

  def initialize(zip, date: nil, city: nil, state: nil, period_1_day: nil, period_1_forecast: nil, period_2_day: nil, period_2_forecast: nil, period_3_day: nil, period_3_forecast: nil, period_4_day: nil, period_4_forecast: nil, period_5_day: nil, period_5_forecast: nil, period_6_day: nil, period_6_forecast: nil, period_7_day: nil, period_7_forecast: nil, period_8_day: nil, period_8_forecast: nil, period_9_day: nil, period_9_forecast: nil, period_10_day: nil, period_10_forecast: nil, error: nil)
    self.zip = zip
    self.date = date
    self.city = city
    self.state = state
    self.period_1_day = period_1_day
    self.period_1_forecast = period_1_forecast
    self.period_2_day = period_2_day
    self.period_2_forecast = period_2_forecast
    self.period_3_day = period_3_day
    self.period_3_forecast = period_3_forecast
    self.period_4_day = period_4_day
    self.period_4_forecast = period_4_forecast
    self.period_5_day = period_5_day
    self.period_5_forecast = period_5_forecast
    self.period_6_day = period_6_day
    self.period_6_forecast = period_6_forecast
    self.period_7_day = period_7_day
    self.period_7_forecast = period_7_forecast
    self.period_8_day = period_8_day
    self.period_8_forecast = period_8_forecast
    self.period_9_day = period_9_day
    self.period_9_forecast = period_9_forecast
    self.period_10_day = period_10_day
    self.period_10_forecast = period_10_forecast
    self.error = error
  end

  def narrative
    Narrative.ten_day(self)
  end

  def self.weather_report_data(response, zip)
    if forecast = response["forecast"]
      forecast_detail = forecast["txt_forecast"]["forecastday"]
      geoinfo = get("http://api.wunderground.com/api/#{ENV["WU_KEY"]}/geolookup/q/#{zip}.json")
      {
        date: response["forecast"]["txt_forecast"]["date"],
        city: geoinfo["location"]["city"],
        state: geoinfo["location"]["state"],
        period_1_day: forecast_detail[0]["title"],
        period_1_forecast: forecast_detail[0]["fcttext"],
        period_2_day: forecast_detail[2]["title"],
        period_2_forecast: forecast_detail[2]["fcttext"],
        period_3_day: forecast_detail[4]["title"],
        period_3_forecast: forecast_detail[4]["fcttext"],
        period_4_day: forecast_detail[6]["title"],
        period_4_forecast: forecast_detail[6]["fcttext"],
        period_5_day: forecast_detail[8]["title"],
        period_5_forecast: forecast_detail[8]["fcttext"],
        period_6_day: forecast_detail[10]["title"],
        period_6_forecast: forecast_detail[10]["fcttext"],
        period_7_day: forecast_detail[12]["title"],
        period_7_forecast: forecast_detail[12]["fcttext"],
        period_8_day: forecast_detail[14]["title"],
        period_8_forecast: forecast_detail[14]["fcttext"],
        period_9_day: forecast_detail[16]["title"],
        period_9_forecast: forecast_detail[16]["fcttext"],
        period_10_day: forecast_detail[18]["title"],
        period_10_forecast: forecast_detail[18]["fcttext"]
      }
    else
      {error: response["response"]["error"]["description"]}
    end
  end

  def self.find(zip)
    key = ENV["WU_KEY"]
    response = get("http://api.wunderground.com/api/#{key}/forecast10day/q/#{zip}.json")
    if response.success?
      self.new(zip, weather_report_data(response, zip))
    else
      raise response.response
    end
  end
end
