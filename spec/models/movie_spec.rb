require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'relationships' do
    it { should belong_to(:studio) }
    it { should have_many(:movie_actors) }
    it { should have_many(:actors).through(:movie_actors) }
  end

  let!(:universal) {Studio.create!(name: 'Universal Studios', location: 'Hollywood')}
  let!(:raiders) {Movie.create!(title: 'The Last Crusade', creation_year: '1989', genre: 'Action Adventure', studio_id: universal.id)}
  let!(:ford) {Actor.create!(name: 'Harrison Ford', age: '38' )}
  let!(:connery) {Actor.create!(name: 'Sean Connery', age: '55' )}
  let!(:davies) {Actor.create!(name: 'John Rhys-Davies', age: '47' )}

  before :each do
    MovieActor.create!(movie: raiders, actor: ford)
    MovieActor.create!(movie: raiders, actor: connery)
    MovieActor.create!(movie: raiders, actor: davies)
  end

  describe '#chronological_actors' do
    it 'organizes actors of a movie in order of age, youngest to oldest' do
      expect(raiders.chronological_actors).to eq([ford, davies, connery])
    end
  end

  describe '#actors_average_age' do
    it 'calculates the average ago of the actors in the movie' do
      expect(raiders.actors_avearge_age).to eq(46.66)
    end
  end 
end
