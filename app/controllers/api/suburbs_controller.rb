class Api::SuburbsController < Api::BaseController
  before_filter :load_suburb, :except => [:index]
  
  def toilets
    respond_with @suburb.toilets, :methods => [:rating, :to_param]
  end
  
  private
  
  def load_suburb
    @suburb = Suburb.find(params[:id])
  end
  
end