# frozen_string_literal: true

require "spec_helper"
require "boxt_ruby_style_guide/filepath_matcher"

RSpec.describe BoxtRubyStyleGuide::FilepathMatcher do
  describe "#all_matches" do
    subject { described_class.new(*test_filepaths).all_matches }

    context "when filepath is special name" do
      let(:test_filepaths) { ["Gemfile", "Rakefile", "foo.gemspec"] }

      it { is_expected.to include("Gemfile") }
      it { is_expected.to include("Rakefile") }
      it { is_expected.to include("foo.gemspec") }
      it { is_expected.not_to include("Foobar") }
      it { is_expected.not_to include("Procfile") }
    end

    context "when filepath is in app dir" do
      let(:test_filepaths) { ["app/models/yep.rb", "app/models/nope.js"] }

      it { is_expected.to include("app/models/yep.rb") }
      it { is_expected.not_to include("app/models/nope.js") }
    end

    context "when filepath is in test dir" do
      let(:test_filepaths) { ["test/models/yep.rb", "test/models/nope.js"] }

      it { is_expected.to include("test/models/yep.rb") }
      it { is_expected.not_to include("test/models/nope.js") }
    end

    context "when filepath is explicitly excluded" do
      let(:test_filepaths) do
        %w[
          db/schema.rb
          test/dummy/db/schema.rb
          Gemfile.lock
          node_modules/my_lib/init.rb
          tmp/cache/my_file.rb
          vendor/bundle/their_lib/init.rb
        ]
      end

      it { is_expected.to be_empty }
    end
  end
end
