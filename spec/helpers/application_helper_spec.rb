require 'spec_helper'

describe ApplicationHelper do

  before do
    @request = OpenStruct.new
    helper.stub(:request).and_return(@request)
  end

  describe "#is_mobile?" do
    it { @request.user_agent = "Mobile"; helper.is_mobile?.should be_true }
    it { @request.user_agent = "webOS"; helper.is_mobile?.should be_true }
    it { @request.user_agent = "iPhone"; helper.is_mobile?.should be_true }
    it { @request.user_agent = "Android"; helper.is_mobile?.should be_true }
    it { @request.user_agent = "iPad"; helper.is_mobile?.should be_false }
    it { @request.user_agent = "Firefox"; helper.is_mobile?.should be_false }
    it { @request.user_agent = "Chrome"; helper.is_mobile?.should be_false }
  end
end