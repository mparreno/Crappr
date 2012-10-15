require 'spec_helper'

describe Suburb do
  subject do 
    Suburb.new(:name => "Test Suburb")
  end

  it { should have_many(:toilets) }
  it { should validate_presence_of(:name) }

  describe "#to_param" do
    before do
      subject.id = 10
    end

    it "should include the suburb name" do
      subject.to_param.should include subject.name.parameterize
    end

    it "should start with the record ID" do
      subject.to_param.match(/\A(\d{1,5})/).captures.first.should eq subject.id.to_s
    end
  end
end
