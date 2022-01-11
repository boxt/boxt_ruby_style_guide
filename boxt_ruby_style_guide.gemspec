# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "boxt_ruby_style_guide/version"

Gem::Specification.new do |spec|
  spec.required_ruby_version = ">= 2.7"
  spec.authors = ["Boxt"]
  spec.description = "Ruby style guide info for BOXT projects, as well as config settings for Rubocop"
  spec.email = ["developers@boxt.co.uk"]
  spec.homepage = "https://github.com/boxt/ruby-style-guide"
  spec.license = "MIT"
  spec.metadata = {
    "rubygems_mfa_required" => "true"
  }
  spec.name = "boxt_ruby_style_guide"
  spec.summary = "Ruby style guide info for BOXT Ruby projects"
  spec.version = BoxtRubyStyleGuide::VERSION

  spec.files = Dir[
    "*.yml",
    "MIT-LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/**/*"
  ]

  # Locking rubocop versions so we can control the pending cops
  spec.add_dependency "rubocop", "1.24.1"
  spec.add_dependency "rubocop-faker", "1.1.0"
  spec.add_dependency "rubocop-rails", "2.13.1"
  spec.add_dependency "rubocop-rake", "0.6.0"
  spec.add_dependency "rubocop-rspec", "2.7.0"
end
