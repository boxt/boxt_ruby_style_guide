# frozen_string_literal: true

require "boxt_ruby_style_guide"
require "boxt_ruby_style_guide/git_diff"
require "boxt_ruby_style_guide/filepath_matcher"
require "rubocop"

namespace :lint do
  desc "Attempt to shell out to find the git base branch"
  task :base_branch do
    branch = `git log --pretty=format:'%D' HEAD^ | grep 'origin/' | head -n1 | sed 's@origin/@@' | sed 's@,.*@@'`
    puts branch.gsub("\n", "")
  rescue StandardError
    puts "master"
  end

  desc "Runs rubocop against all files with committed changes different from base branch"
  task :rubocop do
    file_paths = sanitized_file_paths
    puts "No matching Ruby files changed" and return if file_paths.any?

    auto_flag_opt = ARGV.select { |a| ["-a", "-A"].include?(a) }.first
    exec("bundle exec rubocop #{file_paths.join(' ')} #{auto_flag_opt}".strip)
  end
end

private

# Attempts to find the base branch of the current commit
def find_base_branch
  `bundle exec rake lint:base_branch`.gsub("\n", "")
end

# Returns Array
def sanitized_file_paths
  base_branch = find_base_branch
  puts "Base branch set to #{base_branch}"
  changed_files = BoxtRubyStyleGuide::GitDiff.new(base_branch: base_branch).all
  BoxtRubyStyleGuide::FilepathMatcher.new(*changed_files).all_matches
end
