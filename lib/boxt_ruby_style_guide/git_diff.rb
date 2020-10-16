# frozen_string_literal: true

module BoxtRubyStyleGuide
  # TODO: Write tests for this to ensure we're pulling the desired diff files
  # see: https://github.com/ruby-git/ruby-git
  class GitDiff
    require "git"

    ##
    # List of Git statuses we should test
    # See: https://git-scm.com/docs/git-status#_short_format
    TEST_STATUSES = %w[M A R C U].freeze

    attr_reader :base

    def initialize(base)
      @base = base
    end

    ##
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
    def all
      @all ||= begin
        git.diff(base).name_status
           .select { |_filepath, status| TEST_STATUSES.include?(status) }
           .keys
      end
    end

    private

    def git
      @git ||= Git.open "."
    end
  end
end
