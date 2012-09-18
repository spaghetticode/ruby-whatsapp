require 'spec_helper'

describe RubyWhatsapp::Connection do
  describe '#you_know_me?' do
    it 'returns true when the credentials are correct' do
      connection = create_valid_connection
      connection.you_know_me?.should be_true
    end

    it 'not returns true when the credentials are incorrect' do
      connection = create_invalid_connection
      connection.you_know_me?.should_not be_true
    end
  end

  describe '#encrypt_username' do
    it 'returns an MD5 hash' do
      RubyWhatsapp::Connection.encrypt_username("101010101010101").size.should == 32
      RubyWhatsapp::Connection.encrypt_username("7A:46:82:91:12:2A").size.should == 32
    end
  end
end