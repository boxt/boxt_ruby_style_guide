# frozen_string_literal: true

require "spec_helper"
require 'boxt_ruby_style_guide/railtie'
require 'rake'
RSpec.describe 'BoxtRubyStyleGuide::Ralitie' do

  describe "rake_tasks hook" do
    it "loads the rake tasks from lib/tasks" do
      task_name = "lint:rubocop"
      expect(Rake::Task).to_not be_task_defined(task_name)
      simulate_railtie_init
      expect(Rake::Task).to be_task_defined(task_name)
    end

    private

    ##
    # This method simulates a Railtie being hooked into a Rails app. Not 100% ideal, since
    # we force-call a protected method, but the API for this is relatively stable
    def simulate_railtie_init
      load BoxtRubyStyleGuide.root.join("lib", "boxt_ruby_style_guide", "railtie.rb")
      BoxtRubyStyleGuide::Railtie.instance.send(:run_tasks_blocks, self)
    end
  end
end
