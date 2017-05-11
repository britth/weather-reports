module WeatherData

  class Base
    #attr_accessor *self.class::DATA_POINTS #splat operator
    attr_accessor :error, :zip
    API_BASE = "http://api.wunderground.com/api/#{ENV["WU_KEY"]}"

    def initialize(zip, response)
      self.zip = zip
      set_data_points(response)
    end

    def self.find(zip)
      response = get("#{API_BASE}/#{self::API_ENDPOINT}/q/#{zip}.json")
      if response.success?
        new(zip, response)
      else
        raise response.response
      end
    end
  end
end
