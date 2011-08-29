require 'spec_helper'

describe "Toilets API" do
  
  it "should return valid JSON" do
    get "/toilets.json"
    response.body.should be_valid_json
  end
  
  it "should return valid XML" do
    get "/toilets.xml"
    response.body.should be_valid_json
  end 
  
  context "when ..." do
    
  end

end