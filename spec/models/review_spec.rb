require 'spec_helper'

describe Review do
  subject do
    Review.new(:name => "Tester")
  end
  
  it { should belong_to(:toilet) }
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:value) }
  it { should allow_value(1).for(:value) }
  it { should_not allow_value(-1).for(:value) }
  it { should_not allow_value(5.5).for(:value) }
end
