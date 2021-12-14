require 'rails_helper'

RSpec.describe 'Movie Show' do
  let!(:universal) {Studio.create!(name: 'Universal Studios', location: 'Hollywood')}
  let!(:raiders) {Movie.create!(title: 'The Last Crusade', creation_year: '1989', genre: 'Action Adventure', studio_id: universal.id)}
  let!(:ford) {Actor.create!(name: 'Harrison Ford', age: '38' )}
  let!(:connery) {Actor.create!(name: 'Sean Connery', age: '55' )}
  let!(:davies) {Actor.create!(name: 'John Rhys-Davies', age: '47' )}

  before :each do
    MovieActor.create!(movie: raiders, actor: ford)
    MovieActor.create!(movie: raiders, actor: connery)
    MovieActor.create!(movie: raiders, actor: davies)

    visit "/movies/#{raiders.id}"
  end
  # As a user,
  # When I visit a movie's show page.
  # I see the movie's title, creation year, and genre,
  # and a list of all its actors from youngest to oldest.
  # And I see the average age of all of the movie's actors

  it 'displays a movies title, creation year, and genre' do

    expect(page).to have_content(raiders.title)
    expect(page).to have_content(raiders.creation_year)
    expect(page).to have_content(raiders.genre)
  end

  it 'displays a list of all actors in the movie' do

    expect(page).to have_content(ford.name)
    expect(page).to have_content(connery.name)
    expect(page).to have_content(davies.name)
  end

  it 'displays actors in order of birth, youngest to oldest' do

    expect(ford.name).to appear_before(davies.name)
    expect(davies.name).to appear_before(connery.name)
  end

  it 'displays the average age of the actors in the film' do

    expect(page).to have_content("Average age of actors: 46.67")
  end
end
