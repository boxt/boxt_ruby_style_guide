# frozen_string_literal: true

require "spec_helper"

describe(BoxtRubyStyleGuide) do
  it("is something") { expect(described_class).to(be_a(Module)) }

  it("has a version set") do
    expect(::BoxtRubyStyleGuide::VERSION).to(be_truthy)
  end
end
