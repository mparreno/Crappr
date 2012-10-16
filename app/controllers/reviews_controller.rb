class ReviewsController < ApplicationController
  respond_to :js
  def create
    @review = toilet.reviews.create(params[:review])
    if @review.valid?
      flash[:notice] = "Thank you for reviewing this toilet"
    else
      flash[:error] = "Unable to add review. Please ensure you have selected a rating and name."
    end

    render
  end

  def toilet
    @toilet ||= Toilet.find(params[:toilet_id])
  end
end