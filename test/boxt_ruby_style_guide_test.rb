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
  end

  describe "::root" do
    it "returns the root directory for the gem" do
      expected_path = Pathname.new(File.dirname(__FILE__) + "/..").cleanpath
      assert_equal(expected_path, BoxtRubyStyleGuide.root)
    end

    it "returns a Pathname" do
      assert_kind_of(Pathname, BoxtRubyStyleGuide.root)
    end
  end

end
