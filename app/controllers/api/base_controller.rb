class Api::BaseController < ApplicationController
  respond_to :json, :xml
  skip_before_filter :prepare_for_mobile
end