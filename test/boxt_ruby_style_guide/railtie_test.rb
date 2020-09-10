# frozen_string_literal: true

require "test_helper"

class BoxtRubyStyleGuide::RailtieTest < Minitest::Test
  describe "rake_tasks hook" do
    it "loads the rake tasks from lib/tasks" do
      task_name = "lint:rubocop"
      refute Rake::Task.task_defined?(task_name), "Rubocop task was defined"
      simulate_railtie_init
      assert Rake::Task.task_defined?(task_name), "Rubocop task was not defined"
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
