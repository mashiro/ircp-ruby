module Ircp
  class Flag
    attr_accessor :operator, :modes, :mode_params

    def initialize(options = {})
      @operator = options[:operator]
      @modes = options[:modes] || []
      @mode_params = options[:mode_params] || []
    end

    def plus?
      @operator == '+'
    end

    def minus?
      @operator == '-'
    end
  end
end
