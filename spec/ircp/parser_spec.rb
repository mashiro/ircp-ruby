require 'spec_helper'

shared_context 'parse text' do |text|
  before { @result = Ircp.parse(text) }
  subject { @result }
  let(:result) { @result }
end

shared_examples_for 'message attributes' do |attributes|
  let(:message_class) { example.metadata[:message_class] }
  it { should be_an_instance_of message_class }
  its(:command) { should eq message_class.command }
  attributes.each do |key, value|
    its(key) { should eq value }
  end
end

describe Ircp::Parser do
  describe '#parse' do
    describe 'Password message', :message_class => Ircp::PassMessage do
      context 'PASS secretpasswordhere' do
        include_context 'parse text', description
        include_examples 'message attributes', {
          :password => 'secretpasswordhere'
        }
      end
    end

    describe 'Nick message', :message_class => Ircp::NickMessage do
      context 'NICK Wiz' do
        include_context 'parse text', description
        include_examples 'message attributes', {
          :nickname => 'Wiz'
        }
      end

      context ':WiZ!jto@tolsun.oulu.fi NICK Kilroy' do
        include_context 'parse text', description
        include_examples 'message attributes', {
          :nickname => 'Kilroy',
          :'prefix.raw' => 'WiZ!jto@tolsun.oulu.fi',
          :'prefix.nickname' => 'WiZ',
          :'prefix.user' => 'jto',
          :'prefix.host' => 'tolsun.oulu.fi'
        }
      end
    end

    describe 'User message', :message_class => Ircp::UserMessage do
      context 'USER guest 0 * :Ronnie Reagan' do
        include_context 'parse text', description
        include_examples 'message attributes', {
          :user => 'guest',
          :mode => 0,
          :unused => '*',
          :realname => 'Ronnie Reagan'
        }
      end
    end

    describe 'Oper message', :message_class => Ircp::OperMessage do
      context 'OPER foo bar' do
        include_context 'parse text', description
        include_examples 'message attributes', {
          :name => 'foo',
          :password => 'bar'
        }
      end
    end

    describe 'User mode message', :message_class => Ircp::UserModeMessage do
      context 'MODE WiZ -w' do
        include_context 'parse text', description
        include_examples 'message attributes', {
          :nickname => 'WiZ'
        }
        context 'flags[0]' do
          subject { result.flags[0] }
          its(:operation) { should eq '-' }
          its(:modes) { should eq ['w'] }
        end
      end

      context 'MODE Angel +i' do
        include_context 'parse text', description
        include_examples 'message attributes', {
          :nickname => 'Angel'
        }
        context 'flags[0]' do
          subject { result.flags[0] }
          its(:operation) { should eq '+' }
          its(:modes) { should eq ['i'] }
        end
      end
    end
  end
end
