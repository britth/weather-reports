# require 'minitest/autorun'
# require 'minitest/pride'
require_relative 'test_helper'
require_relative '../weather_data/current_hurricane.rb'

class CurrentHurricaneTest < Minitest::Test
  def setup
    @current_hurricane = WeatherData::CurrentHurricane.new
  end

  def test_initialize
    assert @current_hurricane
  end

  def test_hurricane_parameter_is_an_array
    assert_equal(Array, @current_hurricane.hurricanes.class)
  end
end
