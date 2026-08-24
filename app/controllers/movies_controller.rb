class MoviesController < ApplicationController
  def index
    @movies = ["Starwars", "Lord of the Rings", "The Matrix", "Inception", "Interstellar"]
  end
end
