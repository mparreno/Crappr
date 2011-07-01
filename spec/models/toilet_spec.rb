require 'spec_helper'

describe Toilet do
  before(:all) do
    VALID_ATTRS = %w(name change_rm gender disabled suburb open_hours location lat lng)
  end
  describe "attributes" do
    it "should have necessary attributes" do
      VALID_ATTRS.each do |att|
        Toliet.new.should respond_to(att)
      end
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
