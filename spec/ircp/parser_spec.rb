require 'spec_helper'

shared_context 'parse text' do |text|
  before { @result = Ircp.parse(text) }
  subject { @result }
  let(:result) { @result }
end

shared_examples_for 'a message' do
  let(:message_class) { example.metadata[:message_class] }
  it { should be_an_instance_of message_class }
  its(:command) { should eq message_class.command }
end

describe Ircp::Parser do
  describe '#parse' do
    describe 'Password message', :message_class => Ircp::PassMessage do
      context 'PASS secretpasswordhere' do
        include_context 'parse text', description
        it_should_behave_like 'a message'

        its(:password) { should eq 'secretpasswordhere' }
      end
    end

    describe 'Nick message', :message_class => Ircp::NickMessage do
      context 'NICK Wiz' do
        include_context 'parse text', description
        it_should_behave_like 'a message'

        its(:nickname) { should eq 'Wiz' }
      end

      context ':WiZ!jto@tolsun.oulu.fi NICK Kilroy' do
        include_context 'parse text', description
        it_should_behave_like 'a message'

        its(:nickname) { should eq 'Kilroy' }
        its(:'prefix.raw') { 'WiZ!jto@tolsun.oulu.fi' }
        its(:'prefix.nickname') { should eq 'WiZ' }
        its(:'prefix.user') { should eq 'jto' }
        its(:'prefix.host') { should eq 'tolsun.oulu.fi' }
      end
    end

    describe 'User message', :message_class => Ircp::UserMessage do
      context 'USER guest 0 * :Ronnie Reagan' do
        include_context 'parse text', description
        it_should_behave_like 'a message'

        its(:user) { should eq 'guest' }
        its(:mode) { should eq 0 }
        its(:unused) { should eq '*' }
        its(:realname) { should eq 'Ronnie Reagan' }
      end
    end

    describe 'Oper message', :message_class => Ircp::OperMessage do
      context 'OPER foo bar' do
        include_context 'parse text', description
        it_should_behave_like 'a message'

        its(:name) { should eq 'foo' }
        its(:password) { should eq 'bar' }
      end
    end

    describe 'User mode message', :message_class => Ircp::UserModeMessage do
      context 'MODE WiZ -w +i' do
        include_context 'parse text', description
        it_should_behave_like 'a message'

        context 'RFC1459' do
          it { should_not be_plus }
          it { should be_minus }
          its(:target) { should eq 'WiZ' }
          its(:nickname) { should eq 'WiZ' }
          its(:operator) { should eq '-' }
          its(:modes) { should eq %w|w| }
        end

        context 'RFC2812' do
          context 'First' do
            subject { result.flags[0] }

            it { should_not be_plus }
            it { should be_minus }
            its(:operator) { should eq '-' }
            its(:modes) { should eq %w|w| }
          end

          context 'Second' do
            subject { result.flags[1] }

            it { should be_plus }
            it { should_not be_minus }
            its(:operator) { should eq '+' }
            its(:modes) { should eq %w|i| }
          end
        end
      end
    end

    describe 'Channel mode message', :message_class => Ircp::ChannelModeMessage do
      context 'MODE #Finnish +o Kilroy' do
        include_context 'parse text', description
        it_should_behave_like 'a message'

        it { should be_plus }
        it { should_not be_minus }
        its(:target) { should eq '#Finnish' }
        its(:channel) { should eq '#Finnish' }
        its(:operator) { should eq '+' }
        its(:modes) { should eq %w|o| }
      end

      #context 'MODE &oulu +b *!*@*.edu +e *!*@*.bu.edu' do
      #  include_context 'parse text', description
      #  it_should_behave_like 'a message'

      #  its(:target) { should eq '&oulu' }
      #  its(:channel) { should eq '&oulu' }

      #  context 'First' do
      #    subject { result.flags[0] }

      #    it { should be_plus }
      #    it { should_not be_minus }
      #    its(:operator) { should eq '+' }
      #    its(:modes) { should eq %w|b| }
      #  end

      #  context 'Second' do
      #    subject { result.flags[1] }

      #    it { should be_plus }
      #    it { should_not be_minus }
      #    its(:operator) { should eq '+' }
      #    its(:modes) { should eq %w|e| }
      #  end
      #end
    end
  end
end
