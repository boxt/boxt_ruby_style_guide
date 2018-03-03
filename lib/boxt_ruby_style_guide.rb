# frozen_string_literal: true

require "boxt_ruby_style_guide/railtie" if defined?(Rails)
require "boxt_ruby_style_guide/version"

# BOXT Ruby Style Guide
module BoxtRubyStyleGuide
  class << self
    def install_tasks
      spec = Gem::Specification.find_by_name("boxt_ruby_style_guide")

      Dir[File.join(spec.gem_dir, "tasks/*.rake")].each do |file|
        load(file)
      end
    end
  end
end
