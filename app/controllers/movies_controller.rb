class MoviesController < ApplicationController
  def index
    @movies = Movie.released
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to movie_path(@movie), notice: "#{@movie.title} was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movie_path(@movie), notice: "#{@movie.title} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    if @movie.destroy
      redirect_to movies_path, notice: "#{@movie.title} was successfully deleted."
    else
      redirect_to movies_path, alert: "Failed to delete #{@movie.title}."
    end
  end

  private

  def movie_params
    params.require(:movie).permit(
      :title, :description,
      :rating, :released_on,
      :total_gross, :director,
      :duration, :image_file_name
    )
  end

end
