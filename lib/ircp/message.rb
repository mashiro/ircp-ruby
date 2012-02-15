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
      return @raw unless @raw.nil?

      tokens = []
      tokens.push @prefix unless @prefix.empty?
      tokens.push @command unless @command.nil?
      tokens.push *@params
      tokens.join ' '
    end
  end
end
