require 'ircp/prefix'

module Ircp
  class Message
    attr_accessor :raw, :prefix, :command, :params

    def initialize(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      @raw = options[:raw]
      @prefix = Prefix.new(options[:prefix] || {})
      @command = options[:command]
      @params = args
    end

    def inspect
      variables = instance_variables.map { |name| "#{name.inspect}=#{instance_variable_get(name).inspect}" }
      variables.unshift "#{self.class}"
      "<#{variables.join ' '}>"
    end

    def to_s
      if @raw.nil? || @raw.empty?
        tokens = []
        tokens << @prefix
        tokens << @command
        @params.each { |param| tokens << param }
        msg = tokens.delete_if { |token| token.nil? || token.empty? }.join(' ')
      else
        msg = @raw.to_s
      end

      msg << "\r\n" unless msg.end_with?("\r\n")
      msg
    end
  end
end
