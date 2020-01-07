# frozen_string_literal: true

# rubocop:disable Style/Style/ExpandPathArguments
# NOTE: This is because of Gemfury failing with __dir__
lib = File.expand_path("../lib", __FILE__)
# rubocop:enable Style/Style/ExpandPathArguments
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "boxt_ruby_style_guide/version"

Gem::Specification.new do |spec|
  spec.authors = ["Boxt"]
  spec.description = "Ruby styleguide info for the BOXT projects, as well as config settings for Rubocop"
  spec.email = ["developers@boxt.co.uk"]
  spec.homepage = "https://github.com/boxt/ruby-style-guide"
  spec.license = "MIT"
  spec.name = "boxt_ruby_style_guide"
  spec.summary = "Ruby styleguide info for the BOXT Ruby projects"
  spec.version = BoxtRubyStyleGuide::VERSION

  spec.files = Dir[
    "default.yml",
    "lib/**/*",
    "MIT-LICENSE",
    "Rakefile",
    "README.md",
    "VERSION"
  ]

  spec.add_dependency "rubocop", "~> 0.79"
  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "minitest", "~> 5.11"
  spec.add_development_dependency "minitest-fail-fast", "~> 0.1"
  spec.add_development_dependency "minitest-macos-notification", "~> 0.3"
  spec.add_development_dependency "minitest-reporters", "~> 1.4"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "simplecov", "~> 0.17"
end
