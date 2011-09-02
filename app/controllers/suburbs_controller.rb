class SuburbsController < ApplicationController
  respond_to :html, :js, :mobile
  before_filter :load_suburb, :except => [:index]
  
  def index
    respond_with @suburbs = Suburb.all
  end

  def show
    respond_with @suburb
  end
  
  private
  
  def load_suburb
    @suburb = Suburb.find(params[:id])
  end
  
end