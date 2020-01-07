# frozen_string_literal: true

require "test_helper"

class BoxtRubyStyleGuideTest < Minitest::Test
  describe ::BoxtRubyStyleGuide do
    it "should be something" do
      assert_kind_of Module, ::BoxtRubyStyleGuide
    end

    it "should have a version set" do
      assert ::BoxtRubyStyleGuide::VERSION
    end

    describe "class methods" do
      describe ".install_tasks" do
        it "should do something (or figure out if/how to test)"
      end
    end
  end
end
