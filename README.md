# Ircp

Ircp is a IRC parser for ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'ircp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ircp

## Usage

```ruby
require 'ircp'
msg = Ircp.parse ':Angel!wings@irc.org PRIVMSG Wiz :Are you receiving this message ?'

puts msg.prefix.nick # => 'Angel'
puts msg.prefix.user # => 'wings'
puts msg.prefix.host # => 'irc.org'
puts msg.command     # => 'PRIVMSG'
puts msg.params[0]   # => 'Wiz'
puts msg.params[1]   # => 'Are you receiving this message ?'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
