require 'spec_helper'

describe Ircp::Message do
  describe '#initialize' do
    context 'with args' do
      include_context 'initialize message', 'secretpasswordhere', :command => 'PASS'
      its(:command) { should eq 'PASS' }
      it_should_behave_like 'prefix for', nil
      it_should_behave_like 'params for', 'secretpasswordhere'
    end

    context 'with params' do
      include_context 'initialize message', :command => 'PASS', :params => ['secretpasswordhere']
      its(:command) { should eq 'PASS' }
      it_should_behave_like 'prefix for', nil
      it_should_behave_like 'params for', 'secretpasswordhere'
    end

    context 'with args and params' do
      include_context 'initialize message', 'foo', :command => 'PRIVMSG', :params => ['hello']
      its(:command) { should eq 'PRIVMSG' }
      it_should_behave_like 'prefix for', nil
      it_should_behave_like 'params for', 'foo', 'hello'
    end
  end

  describe '#to_s' do
    include_context 'initialize message', :command => 'TEST', :params => ['foo', 'bar', 'buzz']
    its(:to_s) { should eq "TEST foo bar buzz\r\n" }
  end
end
