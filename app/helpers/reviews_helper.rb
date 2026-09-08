module ReviewsHelper

  def average_stars(movie)
    if movie.reviews.average(:stars).zero?
      content_tag(:strong, "No reviews")
    else
      pluralize(number_with_precision(movie.reviews.average(:stars), precision: 1), "star")
    end
  end
end
