class SuburbsController < ApplicationController
  respond_to :html, :mobile, :json
  before_filter :load_suburb, :except => [:index]
  
  def index
    respond_with @suburbs = Suburb.all
  end

  def show
    respond_to do |format|
      format.mobile { render :template => 'suburbs/mobile/show' }
      format.json   { rener  :json => @suburb }
      format.all
    end
  end
  
  private
  
  def load_suburb
    @suburb = Suburb.find(params[:id])
  end
  
end