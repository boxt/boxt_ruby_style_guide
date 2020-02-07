# frozen_string_literal: true

require("spec_helper")

describe(::BoxtRubyStyleGuide) do
  it("is a Module") { expect(described_class).to(be_a(Module)) }

  it("haves a version set") do
    expect(::BoxtRubyStyleGuide::VERSION).to(be_truthy)
  end
end
