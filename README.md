# BOXT Ruby Style Guide

Ruby style guide info for the BOXT projects, as well as config settings for Rubocop.

## Installation

Add this line to your application's Gemfile:

```ruby
group :development, :test do
  # ...
  gem "boxt_ruby_style_guide",
      branch: "tags/0.0.1",
      git: "git@bitbucket.org:thisiszone/boxt-ruby-style-guide.git"
end
```

And then execute:

```sh
bundle
```

To make the lint rake tasks available to non Rails apps and gems, add the following to the project's `Rakefile`:

```ruby
require "boxt_ruby_style_guide"

BoxtRubyStyleGuide.install_tasks
```

## Usage

### Rubocop Config

Add a `.rubocop.yml` file to the root of your project with the following settings:

```yml
inherit_gem:
  boxt-ruby-style-guide: .rubocop.yml
```

### Lint Rake Tasks

There are a couple of rake tasks added to the project that allow you to run `reek` and `rubocop` against files listed as changed by Git.

To run `reek` against any changed files use:

```sh
rake lint:reek
```

To run `rubocop` against any changed files use:

```sh
rake lint:rubocop
```

If there are no changed files the commands will run against all files.

There are also some useful editor plugins to help with in-editor linting.

Atom:

* [linter-reek](https://atom.io/packages/linter-reek)
* [linter-rubocop](https://atom.io/packages/linter-rubocop)
* [rubocop-auto-correct](https://atom.io/packages/rubocop-auto-correct)

RubyMine:

* reek - Doesn't appear to be editor integration
* [rubocop](https://www.jetbrains.com/help/ruby/rubocop.html)

## Versioning

The version of the engine should be set in the `VERSION` file found in the root of the project. This is then read by the `lib/boxt/ruby/style/guide/core/version.rb` file to set in the engine.

If you are using [Git Flow AVH](https://github.com/petervanderdoes/gitflow-avh) and the default [Git Flow Hooks](https://github.com/jaspernbrouwer/git-flow-hooks) then the `VERSION` file will be updated automatically when creating a 'release' or 'hotfix' tag.
