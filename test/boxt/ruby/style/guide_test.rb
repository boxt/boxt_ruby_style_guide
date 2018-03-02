# frozen_string_literal: true

require "test_helper"
module Boxt
  module Ruby
    module Style
      class GuideTest < Minitest::Test
        describe ::Boxt::Ruby::Style::Guide do
          it "should be something" do
            assert_kind_of Module, ::Boxt::Ruby::Style::Guide
          end

          it "should have a version set" do
            assert ::Boxt::Ruby::Style::Guide::VERSION
          end
        end
      end
    end
  end
end
