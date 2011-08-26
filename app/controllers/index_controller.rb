class IndexController < ApplicationController
  def index
    @toilets = []
    Toilet.top(10).each do |t|
      @toilets << Toilet.find(t.id)
    end
  end
end
