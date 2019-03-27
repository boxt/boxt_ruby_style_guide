# BOXT Ruby Style Guide

Ruby style guide info for the BOXT projects, as well as config settings for Rubocop.

For the most part we are using [this Ruby style guide](https://github.com/bbatsov/ruby-style-guide) as our base guide, with any deviations can be found in the `default.yml` for this project.

[![CircleCI](https://circleci.com/gh/boxt/boxt_ruby_style_guide.svg?style=svg&circle-token=f35d504fcda5a0d8de30f58cdc0ff7f817a9db75)](https://circleci.com/gh/boxt/boxt_ruby_style_guide)

## Installation

Add this line to your application's Gemfile:

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/boxt/logga.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
