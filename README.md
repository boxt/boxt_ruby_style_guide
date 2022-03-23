# BOXT Ruby Style Guide

This repo is now archived in favour of https://github.com/boxt/boxt_rubocop.

[![Gem Version](https://badge.fury.io/rb/boxt_ruby_style_guide.svg)](https://badge.fury.io/rb/boxt_ruby_style_guide)
[![CI](https://github.com/boxt/boxt_ruby_style_guide/actions/workflows/ci.yml/badge.svg)](https://github.com/boxt/boxt_ruby_style_guide/actions/workflows/ci.yml)

Ruby style guide and base Rubocop settings for Boxt Ruby projects.

For the most part we are using [this Ruby style guide](https://github.com/bbatsov/ruby-style-guide) as the base guide, with any deviations can be found in the `default.yml`.

## Requirements

* Ruby 3.0
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

## Usage

Add a `.rubocop.yml` file to the root of your project with the following settings:

```yml
inherit_gem:
  boxt_ruby_style_guide:
    - default.yml # use default cops
    - rails.yml # use Rails cops - see Additional Extensions/Cops
    - rspec.yml # use rspec cops - see Additional Extensions/Cops
```

### NewCops

`NewCops` is enabled by default.

### Additional Extensions/Cops

The following Rubocop gems are also installed with this gem:

* [rubocop-faker](https://github.com/koic/rubocop-faker)
* [rubocop-rails](https://github.com/rubocop-hq/rubocop-rails)
* [rubocop-rake](https://github.com/rubocop-hq/rubocop-rake)
* [rubocop-rspec](https://github.com/rubocop-hq/rubocop-rspec)

To enable add the following to your `.rubocop.yml` file.

```yml
inherit_gem:
  boxt_ruby_style_guide:
  # .... add cops

require:
  - rubocop-faker # if your project is using the Faker gem then add this
  - rubocop-rails # if your project is a Rails app/engine then add this, plus the - rails.yml setting above
  - rubocop-rake # if your project is using rake then add this
  - rubocop-rspec # if your project is using rspec then add this, plus the - rspec.yml setting above
```

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
