# Ircp [![Build Status](https://travis-ci.org/mashiro/ircp-ruby.png?branch=master)](https://travis-ci.org/mashiro/ircp-ruby) [![Dependency Status](https://gemnasium.com/mashiro/ircp-ruby.png)](https://gemnasium.com/mashiro/ircp-ruby)

Ircp is a IRC minimal parser for ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'ircp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ircp

## Usage

```ruby
# Parse
require 'ircp'
msg = Ircp.parse ':Angel!wings@irc.org PRIVMSG Wiz :Are you receiving this message ?'
p msg.prefix.nick # => 'Angel'
p msg.prefix.user # => 'wings'
p msg.prefix.host # => 'irc.org'
p msg.command     # => 'PRIVMSG'
p msg.params[0]   # => 'Wiz'
p msg.params[1]   # => 'Are you receiving this message ?'

# Dump
msg = Ircp::Message.new 'PRIVMSG', 'Wiz', ':Are you receiving this message ?', prefix: {nick: 'Angel', user: 'wings', host: 'irc.org'}
p msg.to_s        # => ':Angel!wings@irc.org PRIVMSG Wiz :Are you receiving this message ?\r\n'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
