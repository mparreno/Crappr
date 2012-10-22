require 'spec_helper'

describe ReviewsController do

  let(:toilet) { FactoryGirl.create(:toilet) }
  let(:valid_attributes) { {:toilet_id => toilet.id, :review => FactoryGirl.attributes_for(:review)} }

  describe "GET index" do
    before do
      get :index, :toilet_id => toilet.id
    end

    it "should assign reviews to @reviews" do
      assigns(:reviews).should be_a Array
    end

    it "should render @reviews as JSON" do
      response.body.should eq assigns(:reviews).to_json
    end
  end

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

  describe "POST create with errors" do
    before do
      post :create, valid_attributes.merge(:review => {}, :format => :json)
    end

    it "should set a flash error" do
      flash[:error].should_not be_empty
    end

    it "should not have created the record" do
      assigns(:review).should_not be_persisted
    end
  end
end