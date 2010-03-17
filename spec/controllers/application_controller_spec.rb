require 'spec_helper'

describe ApplicationController do
  it "should auto update last activity"
  
  describe "if testing for inactivity" do
    it "should do nothing if > 60 seconds until expire"
    it "should render a warning message if < 60 seconds until expire"
    it "should redirect to the login if expired"
  end
end