require 'rails_helper'

RSpec.describe 'Movie Show' do
  let!(:universal) {Studio.create!(name: 'Universal Studios', location: 'Hollywood')}
  let!(:columbia) {Studio.create!(name: 'Columbia Pictures', location: 'Hollywood')}

  let!(:crusade) {Movie.create!(title: 'The Last Crusade', creation_year: '1989', genre: 'Action Adventure', studio_id: universal.id)}
  let!(:harry_sally) {Movie.create!(title: 'When Harry Met Sally', creation_year: '1989', genre: 'RomCom', studio_id: columbia.id)}

  let!(:ford) {Actor.create!(name: 'Harrison Ford', age: '38' )}
  let!(:connery) {Actor.create!(name: 'Sean Connery', age: '55' )}
  let!(:davies) {Actor.create!(name: 'John Rhys-Davies', age: '47' )}
  let!(:elliot) {Actor.create!(name: 'Denholm Elliot', age: '56' )}

  let!(:crystal) {Actor.create!(name: 'Billy Crystal', age: '42' )}
  let!(:ryan) {Actor.create!(name: 'Meg Ryan', age: '28' )}


  before :each do
    MovieActor.create!(movie: crusade, actor: ford)
    MovieActor.create!(movie: crusade, actor: connery)
    MovieActor.create!(movie: crusade, actor: davies)

    MovieActor.create!(movie: harry_sally, actor: crystal)
    MovieActor.create!(movie: harry_sally, actor: ryan)

    visit "/movies/#{crusade.id}"
  end


  it 'displays a movies title, creation year, and genre' do

    expect(page).to have_content(crusade.title)
    expect(page).to have_content(crusade.creation_year)
    expect(page).to have_content(crusade.genre)
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

  # As a user,
  # When I visit a movie show page,
  # I do not see any actors listed that are not part of the movie
  # And I see a form to add an actor to this movie
  # When I fill in the form with the name of an actor that exists in the database
  # And I click submit
  # Then I am redirected back to that movie's show page
  # And I see the actor's name is now listed
  # (You do not have to test for a sad path, for example if the name submitted is not an existing
  it 'does not display any actors that are not part of the movie' do

    expect(page).to_not have_content(crystal.name)
    expect(page).to_not have_content(ryan.name)
  end

  it 'displays a form to add an actory to the movie' do

    expect(page).to have_content("Add an Actor to this film")
  end

  it 'can add an actor to a film' do

    within("#add-an-actor") do
      fill_in(:actor, with: 'Denholm Elliot')
      click_on("Submit")
    end

    expect(curent_path).to eq("/movies/#{crusade.id}")
    expect(page).to have_content(elliot.name)
  end
end
