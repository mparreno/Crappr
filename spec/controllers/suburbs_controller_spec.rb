require 'spec_helper'

describe SuburbsController do

  let(:suburb) { FactoryGirl.create(:suburb) }

  describe "GET index" do
    before do
      get :index
    end

    it "sets a list of suburbs" do
      assigns(:suburbs).should eq Suburb.all
    end

    it "renders the index template" do
      response.should render_template :index
    end
  end

  describe "GET show" do
    before do 
      get :show, :id => suburb.id
    end

    it "should assign the suburb" do
      assigns(:suburb).should eq suburb
    end
    
    it "should render the show template" do
      response.should render_template :show
    end
  end
end