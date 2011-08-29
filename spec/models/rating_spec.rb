require 'spec_helper'

describe Review do
  
  describe "required attributes" do
    before  { @review = Review.new }    
    subject { @review }
    
    context "when normal toilet" do
      it { should respond_to(:value) }
      it { should respond_to(:text) }
      it { should respond_to(:toilet_id) }
      it { should respond_to(:toilet) }
    end
  end
end
