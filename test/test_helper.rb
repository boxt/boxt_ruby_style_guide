# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "boxt_ruby_style_guide"

require "minitest/autorun"
require "minitest/fail_fast"
require "minitest/reporters"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new
)
