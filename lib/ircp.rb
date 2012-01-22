require 'ircp/version'
require 'ircp/parser'
require 'ircp/message'

module Ircp
  class ParseError < StandardError
  end

  def self.message_parser
    @message_parser ||= Ircp::Parser::MessageParser.new
  end

  def self.parse(text)
    node = message_parser.parse(text)
    raise ParseError.new(message_parser.failure_reason) if node.nil?
    node.eval
  end
end
