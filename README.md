# TzuStats [![Build Status](https://travis-ci.org/onfido/tzu_stats.svg)](https://travis-ci.org/onfido/tzu_stats)

TzuStats uses Shopify's terrific [statsd-instrument gem](https://github.com/Shopify/statsd-instrument/) to instrument Tzu commands using StatsD.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tzu_stats'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tzu_stats

## Usage

Once installed in your application, the following statistics will automatically be pushed when `run!` or `run` is called on a Tzu command:

```
# time taken for a successful run (in milliseconds)
[StatsD] measure DoStuff.run:1000.6256770575419

# counts of success, invalid and failed outcomes
[StatsD] increment DoStuff.run.success:1
[StatsD] increment DoInvalidStuff.run.invalid:1
[StatsD] increment DoFailingStuff.run.failure:1
```

The metric key used is `{name of command}.run.{outcome}`.

Use [statsd-instrument](https://github.com/Shopify/statsd-instrument/#configuration) to configure your backend appropriately.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/onfido/tzu_stats.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
