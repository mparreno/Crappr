class Api::ToiletsController < Api::BaseController
  
  before_filter :load_toilet, :except => [:index, :top_10]
  
  def index
    respond_with @toilets = Toilet.all
  end

  def show
    respond_with @toilet, :methods => [ :rating ]
  end
  
  def nearby
    range = params[:range] || 500
    limit = params[:limit] || 3
    @near_toilets = Toilet.near(:origin => [params[:lat], params[:lng]], :within => range).order("distance asc").limit(limit)
    respond_with @near_toilets
  end
  
  def top_10
    @toilets = Toilet.top(10)
    respond_with @toilets , :methods => [ :rating ]
  end
  
  def reviews
    respond_with @reviews = @toilet.reviews
  end
  
  def create_review
    # Whatver josh wants to call it
    value = params[:rating]
    text = params[:comment]
    @toilet.reviews.create :value => value, :text => text
    respond_with @reviews = @toilet.reviews
  end
  
  private
  
  def load_toilet
    @toilet = Toilet.find(params[:id])
  end
  
  
end