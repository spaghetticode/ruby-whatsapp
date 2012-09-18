require 'digest/md5'
require 'httpclient'
require 'nokogiri'
require 'open-uri'

module RubyWhatsapp
  class Connection
    HOST = "bin-short.whatsapp.net"
    PORT = 5222

    def initialize country_code, phone_number, username
      @phone_number = phone_number
      @country_code = country_code
      @username = username
    end

    def you_know_me?
      password = self.class.encrypt_username @username
      url = "https://r.whatsapp.net/v1/exist.php?cc=#{@country_code}&in=#{@phone_number}&udid=#{password}"
      doc = Nokogiri.XML open(url)
      true unless doc.xpath('//exist/response[@status="ok"]').empty?
    end

    def self.encrypt_username username
      string = is_mac_address?(username) ? username*2 : username.reverse
      Digest::MD5.hexdigest string
    end

    def self.is_mac_address? address
      address.split(":").size == 6
    end
  end
end
