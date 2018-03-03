# frozen_string_literal: true

require "rails"

module BoxtRubyStyleGuide
  # Railtie for adding rake tasks etc to Rails
  class Railtie < Rails::Railtie
    rake_tasks do
      files = File.join(File.dirname(__FILE__), "../../tasks/*.rake")
      Dir[files].each { |file| load(file) }
    end
  end
end
