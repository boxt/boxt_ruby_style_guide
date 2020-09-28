# frozen_string_literal: true

# rubocop:disable Style/ExpandPathArguments
# NOTE: This is because of Gemfury failing with __dir__
lib = File.expand_path("../lib", __FILE__)
# rubocop:enable Style/ExpandPathArguments
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "boxt_ruby_style_guide/version"

Gem::Specification.new do |spec|
  spec.required_ruby_version = ">= 2.7"
  spec.authors = ["Boxt"]
  spec.description = "Ruby styleguide info for the BOXT projects, as well as config settings for Rubocop"
  spec.email = ["developers@boxt.co.uk"]
  spec.homepage = "https://github.com/boxt/ruby-style-guide"
  spec.license = "MIT"
  spec.name = "boxt_ruby_style_guide"
  spec.summary = "Ruby styleguide info for the BOXT Ruby projects"
  spec.version = BoxtRubyStyleGuide::VERSION

  spec.files = Dir[
    "MIT-LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "*.yml",
    "lib/**/*"
  ]

  # locking rubocop versions so we can control the pending cops
  spec.add_dependency "rubocop", "0.92.0"
  spec.add_dependency "rubocop-faker", "1.1.0"
  spec.add_dependency "rubocop-rails", "2.8.1"
  spec.add_dependency "rubocop-rspec", "1.43.2"
  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.9"
  spec.add_development_dependency "rspec-nc", "~> 0.3"
  spec.add_development_dependency "simplecov", "~> 0.18"
end
