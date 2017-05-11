# require 'minitest/autorun'
# require 'minitest/pride'
require_relative 'test_helper'
require_relative '../weather_data/astronomy'

class AstronomyTest < Minitest::Test
  def setup
    @valid_report = WeatherData::Astronomy.find('27713')
    @invalid_report = WeatherData::Astronomy.find('00000')
  end

  def test_initialize
    assert @valid_report
    assert @invalid_report
  end

  def test_invalid_zip_code_report_error_is_not_null
    assert_equal("No cities match your search query", @invalid_report.error)
  end

  def test_valid_zip_code_report_error_is_null
    assert_nil(@valid_report.error)
  end

  def test_invalid_zip_code_city_is_null
    assert_nil(@invalid_report.city)
  end

  def test_valid_zip_code_city_is_not_null
    assert_equal("Durham", @valid_report.city)
  end

  def test_invalid_zip_code_sunset_min_is_null
    assert_nil(@invalid_report.sunset_min)
  end

  def test_valid_zip_code_sunset_min_is_not_null
    refute_nil(@valid_report.sunset_min)
  end
end
