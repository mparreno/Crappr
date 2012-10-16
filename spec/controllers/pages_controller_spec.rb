require 'spec_helper'

describe PagesController do
  describe "GET /" do
    before do
      get :home
    end

    it "sets the top 10 toilets" do
      assigns(:toilets).should be_a Array
    end

    it "renders the correct template" do
      response.should render_template :home
    end
  end

  describe "GET /about" do
    before do
      get :about
    end

    it "renders the correct template" do
      response.should render_template :about
    end
  end
end