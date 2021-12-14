class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  def self.co_actors
    #require "pry"; binding.pry
  end
end
