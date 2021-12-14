require 'rails_helper'

RSpec.describe 'Studio Index' do
  let!(:universal) {Studio.create!(name: 'Universal Studios', location: 'Hollywood')}

  before :each do
    universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    universal.movies.create!(title: 'Shrek', creation_year: 2001, genre: 'Comedy')

      visit '/studios'
  end

  it 'displays a studios name and location' do

    expect(page).to have_content(universal.name)
    expect(page).to have_content(universal.location)
  end

  it 'also displays each studios movie titles' do

    expect(page).to have_content("Raiders of the Lost Ark")
    expect(page).to have_content("Shrek")
  end
end
