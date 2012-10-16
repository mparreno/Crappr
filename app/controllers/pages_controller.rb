class PagesController < ApplicationController
  respond_to :html, :mobile
  
  def home
    respond_with @toilets = Toilet.top(10)
  end
  
  def about
    
  end
end
