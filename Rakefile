# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "rspec/core/rake_task"

import "lib/tasks/lint.rake"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob("spec/**/*_spec.rb")
end

desc "Map rake test to rake spec"
task test: :spec
