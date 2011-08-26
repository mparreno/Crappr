class ToiletsController < ApplicationController
  respond_to :html, :js, :mobile
  before_filter :load_toilet, :except => [:index]
  
  def index
    respond_with(@toilets = Toilet.all)
  end

  def show
    @near_toilets = Toilet.near(:origin => @toilet, :within => 0.5).order("distance asc")
    respond_with(@toilet)
  end
  
  def rate
    @toilet.ratings.create :value => params[:rating]
  end
  
  private
  
  def load_toilet
    @toilet = Toilet.find(params[:id])
  end

end
