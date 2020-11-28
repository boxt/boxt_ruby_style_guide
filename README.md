# BOXT Ruby Style Guide

Ruby style guide and base Rubocop settings for Boxt Ruby projects.

For the most part we are using [this Ruby style guide](https://github.com/bbatsov/ruby-style-guide) as the base guide, with any deviations can be found in the `default.yml`.

[![Gem Version](https://badge.fury.io/rb/boxt_ruby_style_guide.png)](https://badge.fury.io/rb/boxt_ruby_style_guide)
[![CircleCI](https://circleci.com/gh/boxt/boxt_ruby_style_guide/tree/master.svg?style=svg)](https://circleci.com/gh/boxt/boxt_ruby_style_guide/tree/master)

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

Rails apps should have access to the lint tasks by default.

## Usage

Add a `.rubocop.yml` file to the root of your project with the following settings:

```yml
inherit_gem:
  boxt_ruby_style_guide:
    - default.yml # use default cops
    - pending.yml # use pending cops
    - rails.yml # use Rails cops - see Additional Extensions/Cops
    - rails-pending.yml # use pending rails cops
    - rspec.yml # use rspec cops
```

### Additional Extensions/Cops

The following Rubocop gems are also installed with this gem:

* [rubocop-faker](https://github.com/koic/rubocop-faker)
* [rubocop-rails](https://github.com/rubocop-hq/rubocop-rails)
* [rubocop-rspec](https://github.com/rubocop-hq/rubocop-rspec)

To enable add the following to your `.rubocop.yml` file.

```yml
inherit_gem:
  boxt_ruby_style_guide:
  # .... add cops

require:
  - rubocop-faker # if your project is using the Faker gem then add this
  - rubocop-rails # if your project is a Rails app/engine then add this, plus the - rails.yml setting above
  - rubocop-rspec # if your project is using rspec then add this, plus the - rspec.yml setting above
```

## Lint Tasks

Lint tasks to run against files listed as changed by Git.

To run `rubocop` against any changed files use:

```sh
RUBOCOP_LINT_BASE=your-base-branch rake lint:rubocop 
```

To run `rubocop` with autofix, use one of the following:

```sh
RUBOCOP_LINT_BASE=your-base-branch rake lint:rubocop -a 
RUBOCOP_LINT_BASE=your-base-branch rake lint:rubocop -A
```


If there are no changed files the commands will run against all files.

## Editor Plugins

There are also some useful Rubocop editor plugins to help with in-editor linting.

### Atom

- [linter-rubocop](https://atom.io/packages/linter-rubocop)
- [rubocop-auto-correct](https://atom.io/packages/rubocop-auto-correct)

### RubyMine

- [rubocop](https://www.jetbrains.com/help/ruby/rubocop.html)

### VSCode

- [ruby-rubocop](https://marketplace.visualstudio.com/items?itemName=misogi.ruby-rubocop)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/boxt/ruby_style_guide.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
