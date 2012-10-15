require 'spec_helper'

# ApplicationController isn't really a proper controller,
# so it's not really easy to spec it directly.
# Since application controllers inherit from it though, we
# can test on any child and it will be fine.
describe ToiletsController do
  describe "#mobile_device?" do
    context "session variable is set" do
      it "should return true" do
        session[:mobile_param] = "1"
        controller.send(:mobile_device?).should be_true
      end
    end
    context "user agent matches" do
      it "should return true" do
        request.user_agent = "Mobile"
        controller.send(:mobile_device?).should be_true
      end
    end
  end
end