require 'ircp/prefix'
require 'ircp/flag'

module Ircp
  class BaseMessage
    attr_accessor :raw, :prefix, :command

    def initialize(options = {})
      @raw = options[:raw]
      @prefix = options[:prefix]
      @command = options[:command] || self.class.command
    end

    def self.command(command = nil)
      @command = command.to_s if command
      @command
    end

    def to_s
      @raw
    end
  end

  class UnknownMessage < BaseMessage
    attr_accessor :params
  end

  class PassMessage < BaseMessage
    command :PASS
    attr_accessor :password
  end

  class NickMessage < BaseMessage
    command :NICK
    attr_accessor :nickname
  end

  class UserMessage < BaseMessage
    command :USER
    attr_accessor :user, :mode, :unused, :realname
  end

  class OperMessage < BaseMessage
    command :OPER
    attr_accessor :name, :password
  end

  class BaseModeMessage < BaseMessage # {{{
    command :MODE
    attr_accessor :target, :flags

    def initialize(options = {})
      @flags = []
      super
    end

    # RFC1459 like helpers {{{
    def flag
      @flags[0] ||= Flag.new
    end

    def flag=(value)
      @flags[0] = value
    end

    def operator
      flag.operator
    end

    def operator=(value)
      flag.operator = value
    end

    def modes
      flag.modes
    end

    def modes=(value)
      flag.modes = value
    end

    def mode_param
      flag.mode_params[0]
    end

    def mode_param=(value)
      flag.mode_params[0] = value
    end

    def plus?
      flag.plus?
    end

    def minus?
      flag.minus?
    end
    # }}}
  end # }}}

  class UserModeMessage < BaseModeMessage
    command :MODE
    alias_method :nickname, :target
    alias_method :nickname=, :target=
  end

  class ChannelModeMessage < BaseModeMessage
    command :MODE
    alias_method :channel, :target
    alias_method :channel=, :target=
  end
end
