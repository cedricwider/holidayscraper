require 'nokogiri'
require 'httparty'

Dir[File.dirname(__FILE__) + '/holiday_scraper/**/*.rb'].each { |file| require file }
