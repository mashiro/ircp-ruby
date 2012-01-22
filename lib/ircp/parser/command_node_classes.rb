require 'ircp/message'

module Ircp
  module Parser
    class BaseCommandNode < Treetop::Runtime::SyntaxNode
      def self.message_class(klass = nil)
        @message_class = klass if klass
        @message_class
      end

      def eval(env)
        message_class = self.class.message_class
        message_class.new(env).tap { |m| set m }
      end

      def set(m)
      end
    end

    class PasswordCommandNode < BaseCommandNode
      message_class PassMessage
      def set(m)
        m.password = password.v.text_value
      end
    end

    class NicknameCommandNode < BaseCommandNode
      message_class NickMessage
      def set(m)
        m.nickname = nickname.v.text_value
      end
    end

    class UserCommandNode < BaseCommandNode
      message_class UserMessage
      def set(m)
        m.user = user.v.text_value
        m.mode = mode.v.text_value.to_i
        m.unused = unused.v.text_value
        m.realname = realname.v.text_value
      end
    end

    class OperCommandNode < BaseCommandNode
      message_class OperMessage
      def set(m)
        m.name = name.v.text_value
        m.password = password.v.text_value
      end
    end

    class UserModeCommandNode < BaseCommandNode
      message_class UserModeMessage
      def set(m)
        m.nickname = nickname.v.text_value
        flags.elements.each do |flag|
          modes = flag.modes.elements.map { |e| e.text_value }
          case flag.op.text_value
          when '+'
            m.plus_modes += modes
          when '-'
            m.minus_modes += modes
          end
        end
        m.plus_modes.uniq!
        m.minus_modes.uniq!
      end
    end
  end
end
