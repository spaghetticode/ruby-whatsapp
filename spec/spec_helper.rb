require File.expand_path '../../lib/ruby-whatsapp', __FILE__

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def valid_credentials
  @valid_credentials ||= YAML.load_file File.join fixture_path, 'valid_credentials.yml'
end

def create_valid_connection
  vc = valid_credentials
  RubyWhatsapp::Connection.new vc["country_code"], vc["phone_number"], vc["username"]
end

def create_invalid_connection credentials={}
  vc = valid_credentials.merge({"username" => '101010101010101'}).merge credentials
  RubyWhatsapp::Connection.new vc["country_code"], vc["phone_number"], vc["username"]
end