require 'ircp/prefix'

module Ircp
  class Message
    attr_accessor :raw, :prefix, :command, :params

    def initialize(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      @raw = options[:raw]
      @prefix = options[:prefix].is_a?(Hash) ? Prefix.new(options[:prefix]) : nil
      @command = options[:command]
      @params = args
    end
  end
end
