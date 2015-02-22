# Cointrader.net

Ruby wrapper for the Cointrader.net API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cointrader.net'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cointrader.net

## Usage

```ruby
Cointrader.configure do |c|
  c.api_key    = 'API_KEY'
  c.api_secret = 'API_SECRET'
end

puts Cointrader.balance
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cointrader.net/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
