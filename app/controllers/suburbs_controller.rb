class SuburbsController < ApplicationController
  respond_to :html, :js, :mobile
  before_filter :load_suburb, :except => [:index]
  
  def index
    respond_with @suburbs = Suburb.all
  end

  def show
    
  end
  
end