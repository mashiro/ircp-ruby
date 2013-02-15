module Ircp
  module Parser
    class MessageNode < Treetop::Runtime::SyntaxNode
      def eval(env = {})
        env[:raw] = text_value
        prefix.v.eval (env[:prefix] ||= {}) unless prefix.empty?
        command.eval env
        params.eval env unless params.empty?
        env
      end
    end

    class ShortPrefixNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:raw] = text_value
        servername.eval env
        env
      end
    end

    class LongPrefixNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:raw] = text_value
        nick.eval env
        user.v.eval env unless user.empty?
        host.v.eval env unless host.empty?
        env
      end
    end

    class NumericReplyNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:command] = text_value
        env[:numeric_reply] = text_value.to_i
        env
      end
    end

    class CommandWithParamsNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        command.eval env
        params.eval env unless params.empty?
        env
      end
    end

    class CommandNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:command] = text_value
        env
      end
    end

    class ParamsNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        params = [middle_values, trailing_value].flatten.compact
        params.last.gsub!(/\r\n$/, '') unless params.empty?
        env[:options] = env[:params] = params
        env
      end

      def middle_values
        middles.elements.map { |e| e.v.text_value }
      end

      def trailing_value
        trailing.v.text_value unless trailing.empty?
      end
    end

    class ServerNameNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:servername] = text_value
        host.eval env
        env
      end
    end

    class HostNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:host] = text_value
        env
      end
    end

    class NickNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:nick] = text_value
        env
      end
    end

    class UserNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:user] = text_value
        env
      end
    end
  end
end
