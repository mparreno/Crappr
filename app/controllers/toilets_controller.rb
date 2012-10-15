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
    @reviews = @toilet.reviews.order('created_at desc').paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.mobile { render :template => 'toilets/mobile/show' }
      format.all
    end
  end
  
  # FIXME wat.
  def rate
    @review = @toilet.reviews.create :name => "Anonymous", :value => params[:rating]
    render
  end
  
  private
  
  def load_toilet
    @toilet = Toilet.find(params[:id])
  end

end
