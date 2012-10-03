require 'spec_helper'

describe Ircp::Prefix do
  describe '#initialize' do
    context 'with servername' do
      before { @prefix = Ircp::Prefix.new(:servername => 'example.com') }
      subject { @prefix }
      its(:servername) { should eq 'example.com' }
    end

    context 'with nick, user and host' do
      before { @prefix = Ircp::Prefix.new(:nick => 'foo', :user => 'bar', :host => 'example.com') }
      subject { @prefix }
      its(:nick) { should eq 'foo' }
      its(:user) { should eq 'bar' }
      its(:host) { should eq 'example.com' }
    end
  end

  describe '#to_s' do
    context 'with servername' do
      before { @prefix = Ircp::Prefix.new(:servername => 'example.com') }
      subject { @prefix }
      its(:to_s) { should eq 'example.com' }
    end

    context 'with nick, user and host' do
      before { @prefix = Ircp::Prefix.new(:nick => 'foo', :user => 'bar', :host => 'example.com') }
      subject { @prefix }
      its(:to_s) { should eq 'foo!bar@example.com' }
    end
  end
end
