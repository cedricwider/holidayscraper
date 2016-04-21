module HolidayScraper
  class Parser

    DATE_PATTERN = /[^,]+, (\d\d?. [^ ]+)(?: - [^,]+, (\d\d?. [^ ]+))?/

    Event = Struct.new(:name, :start_date, :end_date)

    def parse(page)
      events = []
      current_year = nil
      each_table_header_on(page) do |table_header|
        if year_header?(table_header)
          current_year = table_header.text
        elsif event_header?(table_header)
          events << as_event(current_year, table_header)
        end
      end
      events
    end

    private

    attr_reader :page

    def holiday_table(page)
      page.css('#contentboxsub table')
    end

    def each_table_header_on(page, &block)
      holiday_table(page).css('th').each &block
    end

    def as_event(current_year, table_header)
      start_date, end_date = parse_dates(date_string_from(table_header), current_year)
      sanitize(Event.new(table_header.text, start_date, end_date))
    end

    def date_string_from(table_header)
      table_header.next_sibling.next_sibling.text
    end

    def event_header?(table_header)
      table_header.has_attribute?('valign')
    end

    def year_header?(table_header)
      table_header.has_attribute?('colspan')
    end

    def parse_dates(str, year)
      dates = []
      match = DATE_PATTERN.match(str)
      dates << Date.parse_international("#{match[1]} #{year}")
      if match[2]
        dates << Date.parse_international("#{match[2]} #{year}")
      end
      dates
    end

    def sanitize(event)
      event.end_date += 365 if event.end_date && event.end_date < event.start_date
      event
    end
  end
end

# -*- coding: utf-8 -*-
#
# Purpose:
# Extend the date parsing capabilities of Ruby to work with dates with international month names.
#
# Usage:
#
# Date.parse_international(date_string)
# DateTime.parse_international(date_string)
# date_string.to_international_date
#
# Notes:
# 1) This routine works by substituting your local month names (as defined by Date::MONTHNAMES) for the
#    international names when they occur in the date_string.
# 2) As distributed, this code works for French, German, Italian, and Spanish.  You must add the month
#    names for any additional languages you wish to handle.
#

class Date
  def self.parse_international(string)
    parse(month_to_english(string))
  end

  private

  def self.make_hash(names)
    names.inject({}) {|result, name| result[name] = MONTHNAMES[result.count+1] ; result }
  end

  MONTH_TRANSLATIONS = {}
  MONTH_TRANSLATIONS.merge! make_hash(%w/janvier février mars avril mai juin juillet août septembre octobre novembre décembre/) # French
  MONTH_TRANSLATIONS.merge! make_hash(%w/januar	februar	märz	april	mai	juni	juli	august	september	oktober	november	dezember/)  # German
  MONTH_TRANSLATIONS.merge! make_hash(%w/gennaio	febbraio	marzo	aprile	maggio	giugno	luglio	agosto	settembre	ottobre	novembre	dicembre/)  # Italian
  MONTH_TRANSLATIONS.merge! make_hash(%w/enero	febrero	marzo	abril	mayo	junio	julio	agosto	septiembre	octubre	noviembre	diciembre/) # Spanish

  def self.month_to_english(string)
    month_from = string[/[^\s\d,.]+/i]      # Search for a month name
    if month_from
      month_to = MONTH_TRANSLATIONS[month_from.downcase]      # Look up the translation
      return string.sub(month_from, month_to.to_s) if month_to
    end
    return string
  end
end

class DateTime
  def self.parse_international(string)
    parse(Date::month_to_english(string))
  end
end

class String
  def to_international_date
    Date::month_to_english(self).to_date
  end
end
