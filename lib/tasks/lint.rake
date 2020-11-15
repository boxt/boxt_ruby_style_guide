# frozen_string_literal: true

require "boxt_ruby_style_guide"
require "boxt_ruby_style_guide/git_diff"
require "boxt_ruby_style_guide/filepath_matcher"
require "rubocop"
require "byebug"

namespace :lint do
  desc "Runs rubocop against all files with committed changes different from base branch"
  task :rubocop do
    file_paths = sanitized_file_paths
    puts "File paths: #{file_paths.join(', ')}"

    if file_paths.any?
      auto_flag_opt = ARGV.select { |a| ["-a", "-A"].include?(a) }.first
      exec("bundle exec rubocop #{file_paths.join(' ')} #{auto_flag_opt}".strip)
    else
      puts "No Ruby files changed"
    end
  end
end

private

def base_branch
  branch = ARGV.reject { |a| ["lint:rubocop", "-a", "-A"].include?(a) }.first || "master"
  puts "Using #{branch} as base branch to compare against"
  branch
end

# Returns Array of changed Ruby files to pass to rubocop
def sanitized_file_paths
  changed_files = BoxtRubyStyleGuide::GitDiff.new(base_branch: base_branch).all
  BoxtRubyStyleGuide::FilepathMatcher.new(*changed_files).all_matches
end
