require 'rails_helper'

RSpec.describe 'Actor Show' do
  let!(:universal) {Studio.create!(name: 'Universal Studios', location: 'Hollywood')}

  let!(:crusade) {Movie.create!(title: 'The Last Crusade', creation_year: '1989', genre: 'Action Adventure', studio_id: universal.id)}

  let!(:ford) {Actor.create!(name: 'Harrison Ford', age: '38' )}
  let!(:connery) {Actor.create!(name: 'Sean Connery', age: '55' )}
  let!(:davies) {Actor.create!(name: 'John Rhys-Davies', age: '47' )}

  before :each do
    MovieActor.create!(movie: crusade, actor: ford)
    MovieActor.create!(movie: crusade, actor: connery)
    MovieActor.create!(movie: crusade, actor: davies)

    visit "/actors/#{ford.id}"
  end

  # As a user,
  # When I visit an actor's show page
  # I see that actors name and age
  # And I see a unique list of all of the actors this particular actor has worked with.

  it 'displays the actors name and age' do

    expect(page).to have_content(ford.name)
    expect(page).to have_content(ford.age)
  end
end
