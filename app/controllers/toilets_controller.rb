class ToiletsController < ApplicationController
  respond_to :html, :js, :mobile
  before_filter :load_toilet, :except => [:index]

  def index
    @toilets = Toilet.scoped
      .in_suburb(params[:suburb_id])
      .nearby(params[:lat], params[:lng])
      .top(params[:top])
      .limit(params.fetch(:limit, nil))
    @toilets = @toilets.paginate(:page => params[:page]) if params[:page]
    respond_to do |format|
      format.mobile { render :template => 'toilets/mobile/index' }
      format.json   { render :json => @toilets, :methods => [:dist, :rating, :rating_count] }
      format.all
    end
  end

  def show
    @near_toilets = Toilet.near(:origin => @toilet, :within => 0.5).order("distance asc")
    @reviews = @toilet.reviews.order('created_at desc').paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.mobile { render :template => 'toilets/mobile/show' }
      format.json { render :json => @toilet, :methods => [:dist, :rating]}
      format.all
    end
  end

  private

  def load_toilet
    @toilet = Toilet.find(params[:id])
  end

end
