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
# Grep file pattern to make sure we only check files that are .rb
GREP_PATTERN = "'(#{RUBY_DIRS.join('|')})\/.+\.(rb|rake)'"

namespace :lint do
  desc "Runs rubocop against all files with committed changes different from base branch"
  task :rubocop do
    exec("rubocop #{diff_file_paths};")
  end

  private

  # A list of the local file paths of Ruby files with committed changes.
  #
  #   Run a git diff-tree command with the following otions:
  #     -r recursive
  #     --name-only Only return the name of the files
  #      --diff-filter Filter out results that have been deleted on HEAD
  #
  #   Pipe the output from this command through grep to match only Ruby files in the
  #     desired directories
  #
  # Returns String
  def diff_file_paths
    base_branch = ENV.fetch("BRANCH", BASE_BRANCH)
    command = <<~BASH
      git diff-tree -r --name-only --diff-filter=d #{base_branch} HEAD \
        | egrep #{GREP_PATTERN}
    BASH
    file_paths = `#{command}`
    file_paths.gsub(/\n|\r/, " ")
  end
end
