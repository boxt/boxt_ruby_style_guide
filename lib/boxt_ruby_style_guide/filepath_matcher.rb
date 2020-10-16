# frozen_string_literal: true

module BoxtRubyStyleGuide
  ##
  # Sanitizes a list of filepaths based on Rubocops exclusions
  class FilepathMatcher
    require "yaml"

    ##
    # Compare a given filepath with a grep-style filename pattern
    FILPATH_PATTERN_MATCH = proc do |filepath, pattern|
      File.fnmatch(pattern, filepath)
    end

    ##
    # Array of file patterns to make sure we only check files that are Ruby files
    INCLUDE_PATTERNS = %w[
      Gemfile
      Rakefile
      *.gemspec
      **/*.rb
      **/*.rake
    ].freeze

    ##
    # Array of the excluded files from Rubocop default.yml config
    EXCLUDE_PATTERNS = YAML.load_file(
      BoxtRubyStyleGuide.root.join("default.yml")
    ).dig("AllCops", "Exclude")

    attr_reader :filepaths

    def initialize(*filepaths)
      @filepaths = filepaths
    end

    def all_matches
      filepaths.select do |filepath|
        filepath_proc = FILPATH_PATTERN_MATCH.curry.call(filepath)
        INCLUDE_PATTERNS.any?(filepath_proc) && EXCLUDE_PATTERNS.none?(filepath_proc)
      end
    end
  end
end
