require 'spec_helper'

shared_examples 'parse result' do |text, attributes = {}|
  context ":text => '#{text}'" do
    before { @result = Ircp.parse(text) }
    subject { @result }

    its(:command) { should eq example.metadata[:command] }
    attributes.each do |key, value|
      its(key) { should eq value }
    end
  end
end

describe Ircp::Parser do
  describe '#parse' do
    describe 'Password message', :command => 'PASS' do
      it_should_behave_like 'parse result', 'PASS secretpasswordhere', {
        :password => 'secretpasswordhere'
      }
    end

    describe 'Nick message', :command => 'NICK' do
      it_should_behave_like 'parse result', 'NICK Wiz', {
        :nickname => 'Wiz'
      }
      it_should_behave_like 'parse result', ':WiZ!jto@tolsun.oulu.fi NICK Kilroy', {
        :nickname => 'Kilroy',
        :'prefix.raw' => 'WiZ!jto@tolsun.oulu.fi',
        :'prefix.nickname' => 'WiZ',
        :'prefix.user' => 'jto',
        :'prefix.host' => 'tolsun.oulu.fi'
      }
    end

    describe 'User message', :command => 'USER' do
      it_should_behave_like 'parse result', 'USER guest 0 * :Ronnie Reagan', {
        :user => 'guest',
        :mode => 0,
        :unused => '*',
        :realname => 'Ronnie Reagan'
      }
    end

    describe 'Oper message', :command => 'OPER' do
      it_should_behave_like 'parse result', 'OPER foo bar', {
        :name => 'foo',
        :password => 'bar'
      }
    end

    describe 'User mode message', :command => 'MODE' do
      it_should_behave_like 'parse result', 'MODE WiZ -w', {
        :nickname => 'WiZ',
        :minus_modes => ['w']
      }
      it_should_behave_like 'parse result', 'MODE Angel +i', {
        :nickname => 'Angel',
        :plus_modes => ['i']
      }
      it_should_behave_like 'parse result', 'MODE Angel +iwo +iw -iw', {
        :nickname => 'Angel',
        :plus_modes => ['i', 'w', 'o'],
        :minus_modes => ['i', 'w']
      }
    end
  end
end
