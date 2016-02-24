# SerializedVirtualAttributes

## Developing is dropped in favor of [activerecord-typedstore](http://github.com/byroot/activerecord-typedstore)

This gem provides ability to have several attributes in one ActiveRecord serialized column. It might be useful for STI classes, that have some different attributes and you don't want to have separate columns for each class.

## Requirements

This gem requires ActiveRecord 3.0 or higher and ruby 1.9 or higher.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'serialized_virtual_attributes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install serialized_virtual_attributes

## Usage

Just create text column, serialize it to `Hash` and define your virtual attributes using `serialized_virtual_attribute`:
```ruby
  class Server < ActiveRecord::Base
    serialize :configuration, Hash

    # basic attributes
    serialized_virtual_attribute :host, :description, to: :configuration

    # attribute with typecast
    serialized_virtual_attribute :port, to: :configuration, typecast: Integer

    # attributes with prefixed accessors
    serialized_virtual_attribute :name, to: :configuration, prefix: :network
  end
```
Then you are able to use accessors:

```ruby
  serv = Server.new
  serv.host = 'localhost'
  serv.port = 9232
  serv.network_name = 'oxygen'
```

For ActiveRecord < 4 attr_accessible is enabled by default. You can disable it by providing `accessible: false`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/flant/serialized_virtual_attributes.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
