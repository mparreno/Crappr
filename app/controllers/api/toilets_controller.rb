class Api::ToiletsController < Api::BaseController
  
  before_filter :load_toilet, :except => [:index, :top_10, :nearby]
  
  def index
    limit = params[:limit] || nil
    respond_with @toilets = Toilet.limit(limit)
  end

  def show
    respond_with @toilet, :methods => [:rating]
  end
  
  def nearby
    range = params[:range] || 500
    limit = params[:limit] || 3
    @near_toilets = Toilet.near(:origin => [params[:lat], params[:lng]], :within => range).order("distance asc").limit(limit)
    # Dirty hack!! 
    # Found issue here: https://rails.lighthouseapp.com/projects/8994/tickets/4840-to_xml-doesnt-work-in-such-case-eventselecttitle-as-tto_xml
    # TODO: fix later
    respond_with @near_toilets, :except => [:distance], :methods => [:dist]
  end
  
  def top_10
    @toilets = Toilet.top(10)
    respond_with @toilets , :methods => [ :rating ]
  end
  
  def reviews
    respond_with @reviews = @toilet.reviews
  end
  
  def create_review
    value = params[:value]
    text = params[:text]
    name = params[:name]
    
    @review = @toilet.reviews.create :value => value, :text => text, :name => name
    respond_with @review
  end
  
  private
  
  def load_toilet
    @toilet = Toilet.find(params[:id])
  end
  
  
end