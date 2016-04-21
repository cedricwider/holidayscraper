require 'spec_helper'

describe HolidayScraper::Scraper do

  subject { described_class.new }

  it 'downloads a page' do
    expect(subject.page).not_to be nil
  end
end
