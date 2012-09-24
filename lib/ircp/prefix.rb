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
      if @raw.nil? || @raw.empty?
        if @servername
          ":#{servername}"
        else
          tokens = []
          tokens << ":#{@nick}" unless @nick.nil?
          tokens << "!#{@user}" unless @user.nil?
          tokens << "@#{@host}" unless @host.nil?
          tokens.join ''
        end
      else
        @raw.to_s
      end
    end
    alias_method :to_s, :to_irc
  end
end
