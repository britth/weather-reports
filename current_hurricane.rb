require 'httparty'
require_relative './narrative.rb'

class CurrentHurricane
  include HTTParty

  attr_accessor :hurricanes

  def initialize(hurricanes: HTTParty.get("http://api.wunderground.com/api/#{ENV["WU_KEY"]}/currenthurricane/view.json")["currenthurricane"])
    self.hurricanes = hurricanes
  end

  def narrative
    Narrative.hurricanes(self)
  end
end
