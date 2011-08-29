require 'spec_helper'

describe Toilet do
  before(:all) do
  
  end
  describe "required attributes" do
    before  { @toilet = Toilet.new }    
    subject { @toilet }
    
    context "when normal toilet" do
      it { should respond_to(:name) }
      it { should respond_to(:change_rm) }
      it { should respond_to(:disabled) }
      it { should respond_to(:suburb) }
      it { should respond_to(:open_hours) }
      it { should respond_to(:location) }
      it { should respond_to(:lat) }
      it { should respond_to(:lng) }
      it { should respond_to(:rating) }
      it { should respond_to(:reviews) }
      it { should respond_to(:to_param) }
    end

  end
  
end
