# frozen_string_literal: true

require "boxt_ruby_style_guide/railtie" if defined?(Rails)
require "boxt_ruby_style_guide/version"

module BoxtRubyStyleGuide
  class << self
    def install_tasks
      Dir[File.join(gem_spec.gem_dir, "tasks/*.rake")].each do |file|
        load(file)
      end
    end

    private

    def gem_spec
      Gem::Specification.find_by_name("boxt_ruby_style_guide")
    end
  end
end
