class ActorsController < ApplicationController

  def show
    @actor = Actor.find(params[:id])
    require "pry"; binding.pry
  end
end
