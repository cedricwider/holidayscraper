require 'spec_helper'

describe HolidayScraper::Parser do

  subject { described_class.new }
  let(:scraper) { HolidayScraper::Scraper.new url }
  let(:url) { 'http://www.schule-daellikon.ch/de/ferienplan/' }
  let(:page) { scraper.page }

  it 'get years from' do
    events = subject.parse(page)

    expect(events).to be_a Array
    expect(events).not_to be_empty
  end

  it 'gets events per year' do
    events = subject.parse(page)

    expect(events).to be_a Array
    expect(events.select { |event| event.name == 'Weiterbildung' }.first).not_to be nil
  end

  it 'parses dates correctly' do
    holiday = subject.parse(page).select { |event| event.name == 'Sportferien' }.first
    expect(holiday).not_to be nil
    expect(holiday.start_date.to_s).to eq '2016-02-29'
    expect(holiday.end_date.to_s).to eq '2016-03-11'
  end
end
