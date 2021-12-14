class MoviesController < ApplicationController

  def show
    @movie = Movie.find(params[:id])
    if params[:name].present?
      actor = Actor.select {|actor| actor.name == params[:name]}
      @movie.actors << actor
      redirect_to "/movies/#{@movie.id}"
    else
      @movie
    end
  end
end
