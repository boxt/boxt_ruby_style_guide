# frozen_string_literal: true

require "boxt_ruby_style_guide/railtie" if defined?(Rails)
require "boxt_ruby_style_guide/version"

module BoxtRubyStyleGuide

  module_function

  ##
  # Provide a root path helper for the gem root dir
  #
  # Returns Pathname
  def root
    Pathname.new(File.dirname(__dir__))
  end

end
