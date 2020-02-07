# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

import "./tasks/lint.rake"

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

task default: :spec
