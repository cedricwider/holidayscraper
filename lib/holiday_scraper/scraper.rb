module HolidayScraper
  class Scraper

    DAELLIKON_FERIENPLAN_URL = 'http://www.schule-daellikon.ch/de/ferienplan/'

    def initialize(url = DAELLIKON_FERIENPLAN_URL)
      @url = url
    end

    def page
      @page ||= Nokogiri::HTML(HTTParty.get(url))
    end

    private

    attr_reader :url
  end
end
