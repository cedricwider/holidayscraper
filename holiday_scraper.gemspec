# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'holiday_scraper/version'


Gem::Specification.new do |spec|
  spec.name          = "holiday_scraper"
  spec.version       = HolidayScraper::VERSION
  spec.authors       = ["Cedric Wider"]
  spec.email         = ["wider.cedric@gmail.com"]

  spec.summary       = %q{Scrape holidays for Dällikon from the school's official homepage}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/cedricwider/holidayscraper.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # runtime dependencies
  spec.add_runtime_dependency 'httparty'
  spec.add_runtime_dependency 'nokogiri'

  # development dependencies
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
