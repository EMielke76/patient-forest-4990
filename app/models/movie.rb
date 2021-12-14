class Movie < ApplicationRecord
  belongs_to :studio
  has_many :movie_actors
  has_many :actors, through: :movie_actors

  def chronological_actors
    actors.order(age: :asc)
  end
end
