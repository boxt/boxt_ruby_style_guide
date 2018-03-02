# BOXT Ruby Style Guide

Ruby style guide info for the BOXT projects, as well as config settings for Rubocop.

## Installation

Add this line to your application's Gemfile:

```ruby
group :development, :test do
  # ...
  gem "boxt-ruby-style-guide",
      branch: "tags/0.0.1",
      git: "#{thisiszone}/boxt-ruby-style-guide.git"
  gem "reek" # SEE TODOs...
  gem "rubocop" # SEE TODOs...
end
```

And then execute:

```sh
bundle
```

## Usage

TODO: Write usage instructions here

## Versioning

The version of the engine should be set in the `VERSION` file found in the root of the project. This is then read by the `lib/boxt/ruby/style/guide/core/version.rb` file to set in the engine.

If you are using [Git Flow AVH](https://github.com/petervanderdoes/gitflow-avh) and the default [Git Flow Hooks](https://github.com/jaspernbrouwer/git-flow-hooks) then the `VERSION` file will be updated automatically when creating a 'release' or 'hotfix' tag.

## TODOs

* Figure out how not to have to include `reek` and `rubocop` in the project Gemfile
