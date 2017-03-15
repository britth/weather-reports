require 'wordsmith-ruby-sdk'

class Narrative
  Wordsmith.configure do |config|
    config.token = ENV["WS_KEY"]
    #config.url = 'https://api.automatedinsights.com/v1' #optional, this is the default value
  end

  # def projects
  #   projects = Wordsmith::Project.all
  #   puts projects.first
  # end

  def get_content(data)
    project = Wordsmith::Project.find('weather-report')
    template = project.templates.find('currentweather')
    template.generate(data)[:content]
  end
end
