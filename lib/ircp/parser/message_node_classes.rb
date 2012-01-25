module Ircp
  module Parser
    class MessageNode < Treetop::Runtime::SyntaxNode
      def eval(env = {})
        env[:raw] = text_value
        env[:prefix] = prefix.empty? ? nil : prefix.prefix.eval({})
        command_with_params.eval env
      end
    end

    class PrefixNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        Prefix.new env
      end
    end

    class ShortPrefixNode < PrefixNode
      def eval(env)
        env[:raw] = text_value
        servername.eval env
        super env
      end
    end

    class LongPrefixNode < PrefixNode
      def eval(env)
        env[:raw] = text_value
        [nickname, user, host].compact.each { |rule| rule.eval env }
        super env
      end

      def user
        suffix.user.user unless suffix.empty? || suffix.user.empty?
      end

      def host
        suffix.host unless suffix.empty?
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
        env[:params] = [middle_values, trailing_value].flatten.compact
        env
      end

      def middle_values
        heads.elements.map { |e| e.middle.text_value }
      end

      def trailing_value
        tail.trailing.text_value unless tail.empty?
      end
    end

    class ServerNameNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:servername] = text_value
        hostname.eval env
        env
      end
    end

    class HostNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:host] = text_value
        host.eval env
        env
      end
    end

    class HostNameNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:hostname] = text_value
        env
      end
    end

    class HostAddrNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:hostaddr] = text_value
        hostaddr.eval env
        env
      end
    end

    class IP4AddrNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:ip4addr] = text_value
        env
      end
    end

    class IP6AddrNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:ip6addr] = text_value
        env
      end
    end

    class NickNameNode < Treetop::Runtime::SyntaxNode
      def eval(env)
        env[:nickname] = text_value
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
