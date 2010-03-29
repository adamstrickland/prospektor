require 'spec_helper'

describe Admin::UsersController do
  before :each do
    @admin = login_as :admin
  end
  
  describe "if there's a user" do
    before :each do
      @user = mock_user
    end
  
    it "should send a term letter when they're deactivated" do
      User.should_receive(:find).with(any_args()).and_return(@user)
      @user.should_receive(:deactivate!).and_return(true)
      post :deactivate, :format => 'json', :id => @user.id
      response.should be_success
    end
    
  end
end