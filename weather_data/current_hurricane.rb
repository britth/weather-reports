require 'httparty'
require_relative 'base'

module WeatherData
  class CurrentHurricane < Base
    include HTTParty

    attr_accessor :hurricanes

    def initialize(hurricanes: nil)
      self.hurricanes ||=
        HTTParty.get("#{API_BASE}/currenthurricane/view.json")["currenthurricane"]
    end

    def narrative
      puts "Active Hurricanes"
      if hurricanes.count == 0
        puts "There are no hurricanes to report."
      elsif hurricanes.count > 0
        puts "There are currently #{hurricanes.count} active storms: " +
          "#{hurricanes.map{|x| x["stormInfo"]["stormName_Nice"]}.join(", ")}"
      end
    end
  end
end
