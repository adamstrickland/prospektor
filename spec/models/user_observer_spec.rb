require 'spec_helper'

describe UserObserver do
  include ObserverTestHelperMethods
  
  before :each do
    enable_observers
    @user = User.make_unsaved
    @user.should be_valid
  end
  
  describe "should try to deliver a welcome email" do
    before :each do
      UserMailer.should_receive(:deliver_welcome_letter).at_least(:once).with(@user)
    end
    
    it "when the user is created" do
      @user.save
    end
    
    describe "and also a term email" do
      before :each do
        @user.save
        UserMailer.should_receive(:deliver_termination_letter).at_least(:once).with(@user)
      end
      
      it "when the user is deactivated and saved" do
        @user.deactivate
        @user.save
      end
      
      it "when the user is deactivated" do
        @user.deactivate!
      end
    end
  end
end