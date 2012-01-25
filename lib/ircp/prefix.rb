module Ircp
  class Prefix
    attr_accessor :raw, :servername, :nickname, :user, :host

    def initialize(options = {})
      @raw = options[:raw]
      @servername = options[:servername]
      @nickname = options[:nickname]
      @user = options[:user]
      @host = options[:host]
    end

    def to_s
      @raw
    end
  end
end
