require 'httparty'
require_relative './base.rb'

module WeatherData
  class TenDayForecast < Base
    include HTTParty
    API_ENDPOINT = 'forecast10day'

    DATA_POINTS = [:date, :city, :state, :period_1_day, :period_1_forecast, :period_2_day, :period_2_forecast, :period_3_day, :period_3_forecast, :period_4_day, :period_4_forecast, :period_5_day, :period_5_forecast, :period_6_day, :period_6_forecast, :period_7_day, :period_7_forecast, :period_8_day, :period_8_forecast, :period_9_day, :period_9_forecast, :period_10_day, :period_10_forecast]
    attr_accessor(*DATA_POINTS) #splat operator


    def narrative
      "\n10 Day Forecast for #{city}, #{state} (As of #{date}):\n\n#{period_1_day}: #{period_1_forecast}\n#{period_2_day}: #{period_2_forecast}\n#{period_3_day}: #{period_3_forecast}\n#{period_4_day}: #{period_4_forecast}\n#{period_5_day}: #{period_5_forecast}\n#{period_6_day}: #{period_6_forecast}\n#{period_7_day}: #{period_7_forecast}\n#{period_8_day}: #{period_8_forecast}\n#{period_9_day}: #{period_9_forecast}\n#{period_10_day}: #{period_10_forecast}"
    end

    def set_data_points(response)
      if forecast = response["forecast"]
        forecast_detail = forecast["txt_forecast"]["forecastday"]
        geoinfo = self.class.get("http://api.wunderground.com/api/#{ENV["WU_KEY"]}/geolookup/q/#{zip}.json")
          self.date = response["forecast"]["txt_forecast"]["date"]
          self.city = geoinfo["location"]["city"]
          self.state = geoinfo["location"]["state"]
          self.period_1_day = forecast_detail[0]["title"]
          self.period_1_forecast = forecast_detail[0]["fcttext"]
          self.period_2_day = forecast_detail[2]["title"]
          self.period_2_forecast = forecast_detail[2]["fcttext"]
          self.period_3_day = forecast_detail[4]["title"]
          self.period_3_forecast = forecast_detail[4]["fcttext"]
          self.period_4_day = forecast_detail[6]["title"]
          self.period_4_forecast = forecast_detail[6]["fcttext"]
          self.period_5_day = forecast_detail[8]["title"]
          self.period_5_forecast = forecast_detail[8]["fcttext"]
          self.period_6_day = forecast_detail[10]["title"]
          self.period_6_forecast = forecast_detail[10]["fcttext"]
          self.period_7_day = forecast_detail[12]["title"]
          self.period_7_forecast = forecast_detail[12]["fcttext"]
          self.period_8_day = forecast_detail[14]["title"]
          self.period_8_forecast = forecast_detail[14]["fcttext"]
          self.period_9_day = forecast_detail[16]["title"]
          self.period_9_forecast = forecast_detail[16]["fcttext"]
          self.period_10_day = forecast_detail[18]["title"]
          self.period_10_forecast = forecast_detail[18]["fcttext"]
      else
        self.error = response["response"]["error"]["description"]
      end
    end
  end
end
