# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "boxt_ruby_style_guide"

require "minitest/autorun"
require "minitest/fail_fast"
require "minitest/macos_notification"
require "minitest/reporters"

Minitest::Reporters.use!(
  [
    Minitest::Reporters::SpecReporter.new,
    Minitest::Reporters::MacosNotificationReporter.new(title: "BOXT Ruby Style Guide")
  ],
  "test",
  Minitest.backtrace_filter
)
