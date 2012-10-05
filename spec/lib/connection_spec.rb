require 'spec_helper'

module RubyWhatsapp
  describe Connection do
    describe '#you_know_me?' do
      message = <<-MSG
You should not test at this level. This test depends on a live internet
connection, on valid credentials, and on expected results. You're not
testing your code in isolation.
If you really mean to have a more complete test stack then I suggest you
should do some integration testing.
MSG
      pending message do
        it 'returns true when the credentials are correct' do
          connection = create_valid_connection
          connection.you_know_me?.should be_true
        end

        it 'not returns true when the credentials are incorrect' do
          connection = create_invalid_connection
          connection.you_know_me?.should_not be_true
        end
      end
    end

    describe '#encrypt_username' do
      it 'returns an MD5 hash' do
        Connection.encrypt_username("101010101010101").size.should == 32
        Connection.encrypt_username("7A:46:82:91:12:2A").size.should == 32
      end
    end
  end
end
