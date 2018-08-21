require 'rails_helper'

RSpec.describe 'UI', type: :system do

  let(:title) { 'New Media Freak - Weblog van Kevin Tuhumury' }

  before { visit root_url }

  it 'shows the header' do
    expect(page).to have_title title

    within 'header' do
      expect(page).to have_selector 'h1', text: title
    end
  end

  it 'knows which pages are visitable' do
    within 'nav ul' do
      expect(page).to have_selector 'li', text: 'Home'
      expect(page).to have_selector 'li', text: 'Fotografie'
    end
  end

  it 'knows its descriptive navigation' do
    within '#descriptive-navigation' do
      expect(page).to have_selector 'h3', text: "Ben je op zoek naar iets? Zoals mijn artikelen, foto's of apps? Of ben je op zoek naar mijn social media, zoals twitter, flickr, facebook of github?"
    end
  end

  it 'show the footer' do
    within 'footer' do
      expect(page).to have_selector 'p', text: "Copyright 2002 - #{Date.today.year}, Kevin Tuhumury. Alle rechten voorbehouden. Onderdeel van het THMRY netwerk."
      expect(page).to have_selector '#to-top', text: 'Up, up and away'
    end
  end
end
