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
  end
end
