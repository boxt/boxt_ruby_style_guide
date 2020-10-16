# frozen_string_literal: true

require "boxt_ruby_style_guide"
require "rubocop"
require 'yaml'

##
# The base branch to compare HEAD with for changes
BASE_BRANCH = "develop"

##
# Directories containing Ruby files to lint
RUBY_DIRS = %w[app lib test spec].freeze

##
# Array of file patterns to make sure we only check files that are Ruby files
#
INCLUDE_PATTERNS = %w[
  Gemfile
  Rakefile
  *.gemspec
  app/**/*.rb,rake}
  lib/**/*.{rb,rake}
  test/**/*.{rb,rake}
  spec/**/*.{rb,rake}
]

##
# Array of the excluded files from Rubocop default.yml config
EXCLUDE_PATTERNS = YAML.load_file(
  BoxtRubyStyleGuide.root.join("default.yml")
).dig('AllCops', 'Exclude')

namespace :lint do
  desc "Runs rubocop against all files with committed changes different from base branch"
  task :rubocop do
    exec(<<~BASH)
      RUBOCOP_CHANGED_FILES="#{sanitized_file_paths.join(" ")}"
      if [ -z "$RUBOCOP_CHANGED_FILES" ]; then
        echo "No matching Ruby files changed"
      else
        bundle exec rubocop $RUBOCOP_CHANGED_FILES
      fi
    BASH
  end

  private

  # Compare a given filepath with a grep-style filename pattern
  #
  # Returns Boolean
  def match_filepath_with_pattern(filepath, pattern)
    File.fnmatch(pattern, filepath)
  end

  # Returns Array
  def sanitized_file_paths
    proc = method(:match_filepath_with_pattern).to_proc
    diff_file_paths.select do |filepath|
      filepath_proc = proc.curry.call(filepath)
      INCLUDE_PATTERNS.detect { |pattern| filepath_proc.call(pattern) } &&
        EXCLUDE_PATTERNS.none? { |pattern| filepath_proc.call(pattern) }
    end
  end

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
  # Returns Array
  def diff_file_paths
    base_branch = ENV.fetch("RUBOCOP_LINT_BASE", BASE_BRANCH)
    `git diff -r --name-only --diff-filter=d #{base_branch}`.to_s.split
  end
end
