require 'spec_helper'

describe Toilet do
  subject do
    FactoryGirl.build(:toilet)
  end

  it { should have_many(:reviews) }
  it { should belong_to(:suburb) }

  it { should validate_presence_of(:location) }
  it { should allow_value(-90).for(:lat) }
  it { should allow_value(90).for(:lat) }
  it { should_not allow_value(90.1).for(:lat) }
  it { should_not allow_value(-90.1).for(:lat) }

  it { should allow_value(-180).for(:lng) }
  it { should allow_value(180).for(:lng) }
  it { should_not allow_value(180.1).for(:lng) }
  it { should_not allow_value(-180.1).for(:lng) }

  describe "#rating" do
    context "there are no reviews" do
      before do
        subject.reviews = []
      end

      it { subject.rating.should be_nil }
    end

    context "there are reviews" do
      before do
        subject.reviews << FactoryGirl.create_list(:review, 3, :toilet => subject, :value => 3)
        subject.save!
      end

      it { subject.rating.should eq 3 }
    end
  end

  describe "#to_param" do
    before do
      subject.save!
    end

    it { subject.to_param.should include subject.id.to_s }
    it { subject.to_param.should include subject.location.parameterize }
  end
end
