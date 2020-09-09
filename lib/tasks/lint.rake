# frozen_string_literal: true

require "boxt_ruby_style_guide"
require "rubocop"

##
# The base branch to compare HEAD with for changes
BASE_BRANCH = 'develop'

##
# Directories containing Ruby files to lint
RUBY_DIRS = %w[app lib test spec]


##
# Grep file pattern to make sure we only check files that are .rb
GREP_PATTERN = "'(#{RUBY_DIRS.join('|')})\/.*\/.*\.rb'"

namespace :lint do
  desc "Runs rubocop against all .rb files git lists as changed. Will run
  against all files if none changed"
  task :rubocop do |task, branch|
    command = []
    command << "git diff-tree"
    # recursive option
    command << "-r"
    # only show the file name
    command << "--name-only"
    # don't show names of files that have been deleted
    command << "--diff-filter=d"
    # Branches for comparison
    command << ENV.fetch('BRANCH', BASE_BRANCH)
    command << "HEAD"

    # Bash pipe
    command << "|"

    command << "egrep"
    command << GREP_PATTERN
    puts "command: #{command.join(" ")}"
    file_paths = `#{command.join(" ")}`
    puts "file_paths: #{file_paths}"
  end
end
