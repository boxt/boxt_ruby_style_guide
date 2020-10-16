# frozen_string_literal: true

require "boxt_ruby_style_guide"
require "rubocop"

require "boxt_ruby_style_guide/git_diff"
require "boxt_ruby_style_guide/filepath_matcher"

##
# The base branch to compare HEAD with for changes
BASE_BRANCH = "develop"

namespace :lint do
  desc "Runs rubocop against all files with committed changes different from base branch"
  task :rubocop do
    exec(<<~BASH)
      RUBOCOP_CHANGED_FILES="#{sanitized_file_paths.join(' ')}"
      if [ -z "$RUBOCOP_CHANGED_FILES" ]; then
        echo "No matching Ruby files changed"
      else
        bundle exec rubocop $RUBOCOP_CHANGED_FILES
      fi
    BASH
  end

  private

  # Returns Array
  def sanitized_file_paths
    base = ENV.fetch("RUBOCOP_LINT_BASE", BASE_BRANCH)
    changed_files = BoxtRubyStyleGuide::GitDiff.new(base).all
    BoxtRubyStyleGuide::FilepathMatcher.new(*changed_files).all_matches
  end
end
