# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ruby-whatsapp/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Daniele Molteni"]
  gem.email         = ["dani.m.mobile@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ruby-whatsapp"
  gem.require_paths = ["lib"]
  gem.version       = RubyWhatsapp::VERSION

  gem.add_development_dependency "pry"
  gem.add_dependency "httpclient"
  gem.add_dependency "nokogiri"
end
