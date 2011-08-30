class IndexController < ApplicationController
  respond_to :html, :mobile
  
  def index
    respond_with(@toilets = Toilet.top(10))
  end
end
