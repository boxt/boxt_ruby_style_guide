# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "boxt_ruby_style_guide"

# Make sure require "minitest/reporters" is before require "minitest/auto"
require "minitest/reporters"
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  "test",
  Minitest.backtrace_filter
)

require "minitest/autorun"
require "minitest/fail_fast"
