class ReviewsController < ApplicationController

  before_action :set_movie

  def index
    @reviews = @movie.reviews.includes(:user)
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to movie_reviews_path(@movie), notice: "Review was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :stars)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
