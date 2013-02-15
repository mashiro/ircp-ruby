require 'spec_helper'

describe Ircp::Parser do
  describe '#parse' do
    context "PASS secretpasswordhere\r\n" do
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
