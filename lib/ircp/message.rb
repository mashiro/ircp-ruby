require 'ircp/prefix'

module Ircp
  class BaseMessage
    attr_accessor :raw, :prefix, :command

    def initialize(options = {})
      @raw = options[:raw]
      @prefix = options[:prefix]
      @prefix = Prefix.new(@prefix) if !@prefix.nil? && @prefix.is_a?(::Hash)
      @command = options[:command] || self.class.command
    end

    def self.command(command = nil)
      @command = command.to_s if command
      @command
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

  class BaseModeMessage < BaseMessage
    command :MODE
    attr_accessor :plus_modes, :minus_modes

    def initialize(options = {})
      @plus_modes = []
      @minus_modes = []
      super
    end
  end

  class UserModeMessage < BaseModeMessage
    command :MODE
    attr_accessor :nickname
  end
end
