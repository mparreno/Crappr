class Api::ReviewsController < Api::BaseController
  def index
    respond_with @reviews = Review.all
  end
end