require 'spec_helper'

shared_context 'parse text' do |text|
  before { @result = Ircp.parse(text) }
  subject { @result }
  let(:result) { @result }
end

shared_examples_for 'prefix for' do |options|
  subject { result.prefix }
  if options.nil?
    it { should be_nil }
  else
    options.each do |key, value|
      its(key) { should eq value }
    end
  end
end

shared_examples_for 'params for' do |*args|
  subject { result.params }
  args.each.with_index do |arg, index|
    its([index]) { should eq arg }
  end
end

describe Ircp::Parser do
  describe '#parse' do
    context 'PASS secretpasswordhere' do
      include_context 'parse text', description
      its(:command) { should eq 'PASS' }
      it_should_behave_like 'prefix for', nil
      it_should_behave_like 'params for', 'secretpasswordhere'
    end

    context ':testnick USER guest tolmoon tolsun :Ronnie Reagan' do
      include_context 'parse text', description
      its(:command) { should eq 'USER' }
      it_should_behave_like 'prefix for', :servername => 'testnick'
      it_should_behave_like 'params for', 'guest', 'tolmoon', 'tolsun', 'Ronnie Reagan'
    end

    context 'JOIN #foo,#bar fubar,foobar' do
      include_context 'parse text', description
      its(:command) { should eq 'JOIN' }
      it_should_behave_like 'prefix for', nil
      it_should_behave_like 'params for', '#foo,#bar', 'fubar,foobar'
    end

    context 'MODE &oulu +b *!*@*.edu' do
      include_context 'parse text', description
      its(:command) { should eq 'MODE' }
      it_should_behave_like 'prefix for', nil
      it_should_behave_like 'params for', '&oulu', '+b', '*!*@*.edu'
    end

    context ':Angel PRIVMSG Wiz :Hello are you receiving this message ?' do
      include_context 'parse text', description
      its(:command) { should eq 'PRIVMSG' }
      it_should_behave_like 'prefix for', :servername => 'Angel'
      it_should_behave_like 'params for', 'Wiz', 'Hello are you receiving this message ?'
    end

    context 'PRIVMSG #*.edu :NSFNet is undergoing work, expect interruptions' do
      include_context 'parse text', description
      its(:command) { should eq 'PRIVMSG' }
      it_should_behave_like 'prefix for', nil
      it_should_behave_like 'params for', '#*.edu', 'NSFNet is undergoing work, expect interruptions'
    end
  end
end
