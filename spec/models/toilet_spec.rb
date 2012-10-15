require 'spec_helper'

describe Toilet do
  it { should have_many(:reviews) }
  it { should belong_to(:suburb) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:location) }
  it { should allow_value(-90).for(:lat) }
  it { should allow_value(90).for(:lat) }
  it { should_not allow_value(90.1).for(:lat) }
  it { should_not allow_value(-90.1).for(:lat) }

  it { should allow_value(-180).for(:lng) }
  it { should allow_value(180).for(:lng) }
  it { should_not allow_value(180.1).for(:lng) }
  it { should_not allow_value(-180.1).for(:lng) }
end
