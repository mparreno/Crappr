require 'spec_helper'

describe ReviewsController do

  let(:valid_attributes) { {:review => FactoryGirl.attributes_for(:review)} }

  describe "POST create" do
    before do
      post :create, valid_attributes.merge(:format => :js)
    end

    it "should create the record" do
      assigns(:review).should be_persisted
    end

    it "should render the create template" do
      response.should render_template :create
    end
  end
end