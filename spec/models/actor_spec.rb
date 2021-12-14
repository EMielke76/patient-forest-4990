require 'rails_helper'

RSpec.describe Actor, type: :model do
  describe 'relationships' do
    it { should have_many(:movie_actors) }
    it { should have_many(:movies).through(:movie_actors) }
  end
  let!(:universal) {Studio.create!(name: 'Universal Studios', location: 'Hollywood')}

  let!(:crusade) {Movie.create!(title: 'The Last Crusade', creation_year: '1989', genre: 'Action Adventure', studio_id: universal.id)}

  let!(:ford) {Actor.create!(name: 'Harrison Ford', age: '38' )}
  let!(:connery) {Actor.create!(name: 'Sean Connery', age: '55' )}
  let!(:davies) {Actor.create!(name: 'John Rhys-Davies', age: '47' )}

  before :each do
    MovieActor.create!(movie: crusade, actor: ford)
    MovieActor.create!(movie: crusade, actor: connery)
    MovieActor.create!(movie: crusade, actor: davies)
  end

  describe '.co_actors' do
    it 'displays a unique list of co-actors' do
      expect(Actor.co_actors).to eq([connery, davies])
    end
  end
end
