require 'spec_helper'

describe DashboardController do
  describe "after logging in," do
    before do
      login_as :any
    end
    
    describe "if the user hasn't accepted the nda," do
      before do
        @current_user.stub!(:nda_accepted?).and_return(false)
      end
      
      it "show the nda" do
        get :index
        response.should render_template 'dashboard/nda.html.haml'
      end
    end
    
    describe "after seeing the nda," do
      it "they decide to accept" do
        @current_user.should_receive(:nda_accepted=).once.with(true)
        post :terms, :commit => 'I Accept'
        response.should redirect_to :action => 'index'
      end

      it "they decide to decline" do
        @current_user.should_receive(:activated_at=).once.with(nil)
        @current_user.should_receive(:activation_code=).once.with(any_args())
        post :terms, :commit => 'I Decline'
        response.should redirect_to logout_url
      end
    end

    describe "if the user has already accepted the nda," do
      before do
        @current_user.stub!(:nda_accepted?).and_return(true)
      end
      
      describe "if they're a first-time user," do
        before do
          @current_user.stub!(:first_time?).and_return(true)
        end
        
        it "show the getting started page" do
          @current_user.should_receive(:first_time=).once
          get :index
          response.should render_template 'dashboard/getting_started.html.haml'
        end
      end
      
      describe "if they've used the app before," do
        before do
          @current_user.stub!(:first_time?).and_return(false)
        end
        
        it "show the regular dashboard" do
          get :index
          response.should render_template 'dashboard/index.html.haml'
        end
      end
    end
  end
end