# frozen_string_literal: true

require "boxt_ruby_style_guide"
require "rubocop"

##
# The base branch to compare HEAD with for changes
BASE_BRANCH = "develop"

##
# Directories containing Ruby files to lint
RUBY_DIRS = %w[app lib test spec].freeze

##
# Grep file pattern to make sure we only check files that are Ruby files
# This pattern matches the following:
#
# - Gemfile
# - Rakefile
# - *.gemspec
# - app/**/*.{rb,rake}
# - lib/**/*.{rb,rake}
# - test/**/*.{rb,rake}
# - spec/**/*.{rb,rake}
#
GREP_PATTERN = <<~STRING.delete("\n").delete("\s")
  (
    (#{RUBY_DIRS.join('|')})\\/.+\\.(rb|rake)
    |^
    (Gemfile|Rakefile|.+\\.gemspec)
  \Z)
STRING

namespace :lint do
  desc "Runs rubocop against all files with committed changes different from base branch"
  task :rubocop do
    exec(<<~BASH)
      RUBOCOP_CHANGED_FILES=`#{diff_file_paths}`
      if [ -z "$RUBOCOP_CHANGED_FILES" ]; then
        echo "No matching Ruby files changed"
      else
        bundle exec rubocop $RUBOCOP_CHANGED_FILES
      fi
    BASH
  end

  private

  # A list of the local file paths of Ruby files with committed changes.
  #
  #   Run a git diff-tree command with the following otions:
  #     -r recursive
  #     --name-only Only return the name of the files
  #     --diff-filter Filter out results that have been deleted on HEAD
  #
  #   Pipe the output from this command through grep to match only Ruby files in the
  #     desired directories
  #
  # Returns String
  def diff_file_paths
    base_branch = ENV.fetch("RUBOCOP_LINT_BASE", BASE_BRANCH)
    "git diff -r --name-only --diff-filter=d #{base_branch} | egrep '#{GREP_PATTERN}'"
  end
end
