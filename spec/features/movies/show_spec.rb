require 'rails_helper'

RSpec.describe 'Movie Show' do
  let!(:universal) {Studio.create!(name: 'Universal Studios', location: 'Hollywood')}
  let!(:raiders) {Movie.create!(name: 'The Last Crusade', creation_year: '1989', genre: 'Action Adventure', studio_id: universal.id)}
  let!(:ford) {Actor.create!(name: 'Harrison Ford', age: '38' )}
  let!(:connery) {Actor.create!(name: 'Sean Connery', age: '55' )}
  let!(:davies) {Actor.create!(name: 'John Rhys-Davies', age: '47' )}

  before :each do
    MovieActor.create!(movie: raiders, actor: ford)
    MovieActor.create!(movie: raiders, actor: connery)
    MovieActor.create!(movie: raiders, actor: davies)
  end
  # As a user,
  # When I visit a movie's show page.
  # I see the movie's title, creation year, and genre,
  # and a list of all its actors from youngest to oldest.
  # And I see the average age of all of the movie's actors

  it 'displays a movies title, creation year, and genre' do

    visit "/movies/#{raiders.id}"

    expect(page).to have_content(raiders.name)
    expect(page).to have_content(raiders.creation_year)
    expect(page).to have_content(raiders.genre)
  end 
end
