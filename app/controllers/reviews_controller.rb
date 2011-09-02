class ReviewsController < ApplicationController
  respond_to :html, :js
  def create
    @review = Review.create!(params[:review])
    flash[:notice] = "Thank you for reviewing this toilet"
    respond_with @review
  end
end