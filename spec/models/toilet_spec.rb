require 'spec_helper'

describe Toilet do
  before(:all) do
    VALID_ATTRS = %w(name change_rm gender disabled suburb open_hours location lat lng)
  end
  describe "attributes" do
    it "should have necessary attributes" do
      VALID_ATTRS.each do |att|
        Toilet.new.should respond_to(att)
      end
    end
  end
  
  describe "Class method - near" do
    pending "Should find all toilets near a location"
  end
  
end
