# BOXT Ruby Style Guide

Ruby style guide info for the BOXT projects, as well as config settings for Rubocop.

For the most part we are using [this Ruby style guide](https://github.com/bbatsov/ruby-style-guide) as our base guide, with any deviations can be found in the `default.yml` for this project.

## Installation

We are now using Gemfury to host all our private packages. Please ensure you have added your private repo URL from Gemfury to the application's Gemfile, example:

```ruby
source 'https://qVz5xDENYkkuVWQ37cb5@gem.fury.io/boxt/'
```

Then add this line to your application's Gemfile:

```ruby
group :development, :test do
  # ...
  gem "boxt_ruby_style_guide"
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

Rails apps should have access to the lint tasks by default.

## Usage

### Reek Config

The Reek config is loaded automatically by this gem so there shouldn't be anything that you need to do. However am not sure if this will effect using in-editor linters.

### Rubocop Config

Add a `.rubocop.yml` file to the root of your project with the following settings:

```yml
inherit_gem:
  boxt-ruby-style-guide:
    - default.yml
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
