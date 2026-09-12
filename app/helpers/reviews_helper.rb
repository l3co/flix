module ReviewsHelper

  def average_stars(movie)
    review_avg = movie.reviews.average(:stars)
    if review_avg.nil?
      content_tag(:strong, "No reviews")
    else
      pluralize(number_with_precision(review_avg, precision: 1), "star")
    end
  end
end
