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
      url = "https://r.whatsapp.net/v1/exist.php?cc=#{@country_code}&in=#{@phone_number}&udid=#{encrypted_password}"
      doc = Nokogiri.XML open(url)
      true unless doc.xpath('//exist/response[@status="ok"]').empty?
    end

    def encrypted_password
      Digest::MD5.hexdigest @username.reverse
    end
  end
end
