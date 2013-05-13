require 'ircp/prefix'

module Ircp
  class Message
    CRLF = "\r\n"

    attr_accessor :raw, :prefix, :command, :params

    def initialize(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      @raw = options[:raw]
      @prefix = options[:prefix] ? Prefix.new(options[:prefix]) : nil
      @command = options[:command] || args.shift
      @params = args + Array(options[:params])
      yield self if block_given?
    end

    def inspect
      variables = instance_variables.map { |name| "#{name}=#{instance_variable_get(name).inspect}" }
      variables.unshift "#{self.class}"
      "<#{variables.join ' '}>"
    end

    def to_irc
      command = @command.to_s.upcase

      tokens = []
      tokens << ":#{@prefix}" if @prefix
      tokens << command

      new_params = @params.dup
      unless new_params.empty?
        last = new_params.pop.to_s.dup
        last.insert 0, ':' if !last.start_with?(':') && last.include?(' ')
        new_params << last
      end
      tokens += new_params

      msg = tokens.map { |token| token.to_s }.reject { |token| token.empty? }.join(' ')
      msg << CRLF unless msg.end_with?(CRLF)
      msg
    end
    alias_method :to_s, :to_irc
  end
end
