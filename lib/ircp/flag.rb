module Ircp
  class Flag
    attr_accessor :operation, :modes, :limit, :user, :ban_mask
    alias_method :op, :operation
    alias_method :op=, :operation=

    def initialize(options = {})
      @operation = options[:operation]
      @modes = options[:modes] || []
      @limit = options[:limit]
      @user = options[:user]
      @ban_mask = options[:ban_mask]
    end
  end
end
