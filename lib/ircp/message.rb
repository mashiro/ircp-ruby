require 'ircp/prefix'

module Ircp
  class Message
    attr_accessor :raw, :prefix, :command, :params

    def initialize(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      @raw = options[:raw]
      @prefix = options[:prefix] ? Prefix.new(options[:prefix]) : nil
      @command = options[:command]
      @params = args + Array(options[:params])
    end

    def inspect
      variables = instance_variables.map { |name| "#{name.inspect}=#{instance_variable_get(name).inspect}" }
      variables.unshift "#{self.class}"
      "<#{variables.join ' '}>"
    end

    def to_irc
      msg = [@prefix, @command, *@params].map { |v| v.to_s }.reject { |v| v.empty? }.join(' ')
      msg << "\r\n" unless msg.end_with?("\r\n")
      msg
    end
    alias_method :to_s, :to_irc
  end
end
