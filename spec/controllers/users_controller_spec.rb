require 'spec_helper'

describe UsersController do
  before :each do
    # @user = mock_user :any
    
    @uid = 999
    @user = mock_user :any, :id => @uid
  end
  
  describe "should show the profile for the user" do
    before :each do
      Notifier.should_not_receive(:deliver_snoop_alert)
    end
    
    after :each do
      response.should be_success
      response.should render_template('users/edit.html.haml')
    end
    
    it "if the current_user is the requested user" do
      current_user = login_using(@user)
      
      current_user.id.should_not be_nil
      current_user.should_not be_is_admin
      
      User.find(current_user.id).should be current_user
      User.find(@user.id).should be @user
      
      get :edit, :id => @user.id
    end
    
    it "if the current_user is an admin" do
      current_user = login_as :admin
      
      current_user.id.should_not eql @uid
      @user.id.should_not eql(current_user.id)
      
      get :edit, :id => @user.id
    end
  end
  
  describe "should not show the profile for the user" do
    before :each do
      Notifier.should_receive(:deliver_snoop_alert)
    end
    
    after :each do
      response.should be_success
      response.should render_template('users/quit_snooping.html.haml')
    end
    
    it "if the current_user is neither an admin or the user requested" do
      current_user = login_as :any      
      current_user.should_not be_is_admin
      
      current_user.id.should_not eql @uid
      @user.id.should_not eql(current_user.id)
      
      get :edit, :id => @user.id
    end    
  end
end
