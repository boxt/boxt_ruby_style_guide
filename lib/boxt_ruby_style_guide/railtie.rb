require "rails"

module BoxtRubyStyleGuide
  class Railtie < Rails::Railtie
    rake_tasks do
      files = BoxtRubyStyleGuide.root.join("lib", "tasks", "*.rake")
      Dir[files].each { |file| load(file) }
    end
  end
end
