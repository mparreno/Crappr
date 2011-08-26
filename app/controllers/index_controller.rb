class IndexController < ApplicationController
  respond_to :html
  
  def index
    respond_with(@toilets = Toilet.top(10))
  end
end
