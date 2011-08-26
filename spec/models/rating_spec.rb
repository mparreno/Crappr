require 'spec_helper'

describe Rating do
  
  describe "required attributes" do
    before  { @rating = Rating.new }    
    subject { @rating }
    
    context "when normal toilet" do
      it { should respond_to(:value) }
      it { should respond_to(:toilet_id) }
      it { should respond_to(:toilet) }
    end
  end
end
