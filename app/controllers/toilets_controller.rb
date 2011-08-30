class ToiletsController < ApplicationController
  respond_to :html, :js, :mobile
  before_filter :load_toilet, :except => [:index]
  
  def index
    @toilets = Toilet.all
    respond_to do |format|
      format.mobile { render :template => 'toilets/mobile/index' }
      format.all
    end
  end

  def show
    @near_toilets = Toilet.near(:origin => @toilet, :within => 0.5).order("distance asc")
    respond_to do |format|
      format.mobile { render :template => 'toilets/mobile/show' }
      format.all
    end
  end
  
  def rate
    @toilet.reviews.create :value => params[:rating]
  end
  
  private
  
  def load_toilet
    @toilet = Toilet.find(params[:id])
  end

end
