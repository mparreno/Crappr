class Api::ToiletsController < Api::BaseController
  def nearby_crappers
    range = params[:range] || 500
    limit = params[:limit] || 3
    @near_toilets = Toilet.near(:origin => [params[:lat], params[:lng]], :within => range).order("distance asc").limit(limit)
    respond_with @near_toilets
  end
  
  def rating
  end
  
  def top_10
  end
end