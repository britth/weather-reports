require 'wordsmith-ruby-sdk'

module Narrative
  extend self

  Wordsmith.configure do |config|
    config.token = ENV["WS_KEY"]
  end

  def content(data)
    project = Wordsmith::Project.find('weather-report')
    template = project.templates.find('currentweather')
    template.generate(data)[:content]
  end
end
