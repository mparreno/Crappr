class Api::BaseController < ApplicationController
  respond_to :json, :xml
  skip_before_filter :prepare_for_mobile
  before_filter :set_default_format
  
  def set_default_format
    request.format = :xml unless params[:format]
  end
  
end