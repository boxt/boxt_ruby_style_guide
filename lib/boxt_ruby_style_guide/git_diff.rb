# frozen_string_literal: true

module BoxtRubyStyleGuide
  # Returns a list of files that have changed, as detected by `git-diff`
  #
  # TODO: Write tests for this to ensure we're pulling the desired diff files
  # see: https://github.com/ruby-git/ruby-git
  class GitDiff
    require "git"

    ##
    # List of Git statuses we should test
    # See: https://git-scm.com/docs/git-status#_short_format
    TEST_STATUSES = %w[M A U].freeze

    attr_reader :base

    def initialize(base = "master")
      @base = base
    end

    ##
    # A list of the local file paths of Ruby files with committed changes.
    #
    # Returns Array
    def all
      @all ||= begin
        git.diff(base).name_status.select { |_, stat| TEST_STATUSES.include?(stat) }.keys
      end
    end

    private

    def git
      @git ||= Git.open(".")
    end
  end
end
