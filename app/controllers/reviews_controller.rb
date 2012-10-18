class ReviewsController < ApplicationController
  respond_to :js

  def index
    render :json => toilet.reviews
  end

  def create
    @review = toilet.reviews.create!(params[:review])
    if @review.valid?
      flash[:notice] = "Thank you for reviewing this toilet"
    else
      flash[:error] = "Unable to add review. Please ensure you have selected a rating and name."
    end

    respond_to do |format|
      format.js { render }
      format.json { render :json => @review }
    end
  end

  def toilet
    @toilet ||= Toilet.find(params[:toilet_id])
  end
end