require 'spec_helper'

describe ToiletsHelper do
  helper ToiletsHelper


  describe "#distanceize" do
    let(:distance) { 1 }
    let(:unit_regexp) { /\d+([a-z]*)/ }

    context "into meters" do
      it "should return the correct number" do
        distanceize(distance, 'm').to_i.should eq 1000
      end

      it "should be in the correct unit" do
        distanceize(distance, 'm')
        .match(unit_regexp)
        .captures.first.should eq "m"
      end
    end

    context "into kilometers" do
      it "should return the correct number" do
        distanceize(distance, 'km').to_i.should eq 1
      end

      it "should be in the correct unit" do
        distanceize(distance, 'km')
        .match(unit_regexp)
        .captures.first.should eq "km"
      end
    end

    context "unknown type" do
      it "should return the correct number" do
        distanceize(distance, 'mm').to_i.should eq 1000
      end

      it "should use the default unit" do
        distanceize(distance, 'mm')
        .match(unit_regexp)
        .captures.first.should eq "mm"
      end
    end
  end
  
end