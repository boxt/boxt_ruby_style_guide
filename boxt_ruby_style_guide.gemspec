# frozen_string_literal: true

# rubocop:disable Styles/ExpandPathArguments
# NOTE: This is because of Gemfury failing with __dir__
lib = File.expand_path("../lib", __FILE__)
# rubocop:enable Styles/ExpandPathArguments
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "boxt_ruby_style_guide/version"

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.authors       = ["Stuart Chinery"]
  spec.description   = "Ruby styleguide info for the BOXT projects, as well as"\
                       "config settings for Rubocop"
  spec.email         = ["stuart.chinery@gmail.com"]
  spec.homepage      = "https://github.com/boxt/ruby-style-guide"
  spec.license       = "MIT"
  spec.name          = "boxt_ruby_style_guide"
  spec.summary       = "Ruby styleguide info for the BOXT Ruby projects"
  spec.version       = BoxtRubyStyleGuide::VERSION

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # 'allowed_push_host' to allow pushing to a single host or delete this
  # section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "reek", "~> 4.7"
  spec.add_dependency "rubocop", "~> 0.52"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-fail-fast", "~> 0.1"
  spec.add_development_dependency "minitest-macos-notification"
  spec.add_development_dependency "minitest-reporters", "~> 1.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "simplecov"
end
# rubocop:enable Metrics/BlockLength
