# Configurable Search

Configurable parameters for your elastic search queries. Like strong
params, but, like, better.

## Dependencies

It works with [Tire](https://github.com/karmi/retire) at the
minute and depends on a lot of Rails things. Expect it to change in future.

## Installation

Add this line to your application's Gemfile:

    gem 'configurable_search'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install configurable_search

## Usage

Mix it in to your class to enjoy the DSL niceness...

```ruby
class AwesomeSearch

  include ConfigurableSearch

  # State which model should be used for searching
  search_for Awesome

  # Add the options you want to be passed into the query
  # anything not here will be ommitted
  search_option :volume, default: 11, label: 'Volume level'

  # Define the query itself
  def query
    search do |s|
      ...
    end
  end
end
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/configurable_search/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
