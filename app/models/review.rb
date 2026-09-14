class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :comment, length: { minimum: 4 }

  STARS = [1, 2, 3, 4, 5]

  validates :stars, inclusion: {
    in: STARS,
    message: "must be between 1 and 5"
  }

  def average_stars
    movie.reviews.average(:stars) || 0.0
  end
end
