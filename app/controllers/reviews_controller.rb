class ReviewsController < ApplicationController
  respond_to :js
  def create
    # TODO this should always be creating on a toilet object
    @review = Review.create(params[:review])
    
    if @review.valid?
      flash[:notice] = "Thank you for reviewing this toilet"
    else
      flash[:error] = "Unable to add review. Please ensure you have selected a rating and name."
    end
    respond_with @review
  end
end