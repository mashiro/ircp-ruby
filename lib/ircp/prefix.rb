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

    def to_s
      return @raw unless @raw.nil?

      if @servername
        ":#{servername}"
      else
        tokens = []
        tokens.push ":#{@nick}" unless @nick.nil?
        tokens.push "!#{@user}" unless @user.nil?
        tokens.push "@#{@host}" unless @host.nil?
        tokens.join ''
      end
    end
  end
end
