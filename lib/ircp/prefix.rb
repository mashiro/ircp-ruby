module Ircp
  class Prefix
    attr_accessor :raw, :servername, :nick, :user, :host

    def initialize(options = {})
      @raw = options[:raw]
      @servername = options[:servername]
      @nick = options[:nick]
      @user = options[:user]
      @host = options[:host]
    end

    def empty?
      to_s.empty?
    end

    def inspect
      variables = instance_variables.map { |name| "#{name.inspect}=#{instance_variable_get(name).inspect}" }
      variables.unshift "#{self.class}"
      "<#{variables.join ' '}>"
    end

    def to_irc
      if @servername
        ":#{servername}"
      else
        [[':', @nick], ['!', @user], ['@', @host]].map do |mark, value|
          "#{mark}#{value}" unless value.to_s.empty?
        end.compact.join('')
      end
    end
    alias_method :to_s, :to_irc
  end
end
