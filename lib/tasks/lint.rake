# frozen_string_literal: true

require "boxt_ruby_style_guide"
require "rubocop"

require "boxt_ruby_style_guide/git_diff"
require "boxt_ruby_style_guide/filepath_matcher"

##
# The default base branch to compare HEAD with for changes
DEFAULT_BASE_BRANCH = "develop"

##
# Name of the master Rubocop lint task to run
RUBOCOP_TASK_NAME = :"lint:execute_rubocop"

##
# Pattern for matching autofix options
AUTO_REGEX = /\A-a\Z/i.freeze

namespace :lint do
  desc "Runs rubocop against all files with committed changes different from base branch"
  task :rubocop do
    Rake::Task[RUBOCOP_TASK_NAME].invoke
  end

  desc "Runs rubocop against all files using -a (soft autofix) option"
  task :rubocop_a do
    Rake::Task[RUBOCOP_TASK_NAME].invoke("-a")
  end

  desc "Runs rubocop against all files using -A (hard autofix) option"
  task :rubocop_A do
    Rake::Task[RUBOCOP_TASK_NAME].invoke("-A")
  end

  task :execute_rubocop, [:auto_flag] do |_t, args|
    if sanitized_file_paths.any?
      # Sanitize args to make sure only a single "a" or "A" is accepted
      auto_flag = AUTO_REGEX.match(args[:auto_flag])
      exec("bundle exec rubocop #{sanitized_file_paths.join(' ')} #{auto_flag}".strip)
    else
      puts "No matching Ruby files changed"
    end
  end
end

private

# Attempts to find the base branch of the current commit
def base_branch
  branch = exec("git log --pretty=format:'%D' HEAD^ | grep 'origin/' | head -n1 | sed 's@origin/@@' | sed 's@,.*@@'")
  branch.gsub("\n", "")
rescue StandardError
  DEFAULT_BASE_BRANCH
end

# Returns Array
def sanitized_file_paths
  # base_branch = ENV.fetch("RUBOCOP_LINT_BASE", DEFAULT_BASE_BRANCH)
  changed_files = BoxtRubyStyleGuide::GitDiff.new(base_branch: base_branch).all
  BoxtRubyStyleGuide::FilepathMatcher.new(*changed_files).all_matches
end
