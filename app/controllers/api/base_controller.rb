class Api::BaseController < ApplicationController
  respond_to :json
  skip_before_filter :prepare_for_mobile
end