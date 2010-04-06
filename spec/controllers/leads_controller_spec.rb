require 'spec/spec_helper'

describe LeadsController do
  before :each do
    @user = login_as :any
    @users = [@user]
    @lead = stub_model(Lead)
    Lead.stub!(:find).with(any_args()).and_return(@lead)
    @other_id = [42, 13].reject{|i| i == @user.id}.first
  
  end

  describe "GET" do
    
    describe "index" do
      describe "if no user supplied," do
        before :each do
        end
      
        it "should show a paginated view of all leads if the current_user is an admin" do
          # Lead.should_receive(:)
          @lead.should_receive(:paginate).with(any_args()).and_return([@lead])
          @user = login_as :admin
          get :index
          response.should render_template 'leads/index.html.haml'
        end

        describe "should show an error if the current_user is NOT an admin" do
          it "should work if HTML is the MIME" do
            get :index
            response.should render_template 'leads/error.html.haml'
          end
        end
      end

      describe "if a user is supplied" do
        describe "should show an error if the supplied user is not the current_user" do
          it "using html mime" do
            get :index, :user_id => @other_id
            response.should render_template 'leads/error.html.haml'
          end
        
          it "using ajax mime" do
            get :index, :format => 'ajax', :user_id => @other_id
            response.should render_template 'leads/error.html.haml'
          end
        end

        describe "should show a paginated view of the leads that belong to the supplied user" do
          before :each do
            # @lead.should_receive(:paginate).with(any_args()).and_return([@lead])
            @lead.stub!(:paginate).with(any_args()).and_return([@lead])
            @other_user = mock_model(User)
            User.stub!(:find).with(@other_id).and_return(@other_user)
            User.stub!(:find).with(@other_id.to_s).and_return(@other_user)            
            @other_user.stub!(:leads).and_return([@lead])
          end
        
          it "if the user supplied is the current_user" do
            @user.stub!(:leads).and_return([@lead])
            get :index, :user_id => @user.id
            response.should render_template 'leads/index.html.haml'
          end
        
          it "if the current_user is an admin" do
            @user = login_as :admin
            @user.stub!(:leads).and_return([@lead])
          
            get :index, :user_id => @other_id
            response.should render_template 'leads/index.html.haml'
          end
        end
      end
    end
  
    describe "show" do
      it "should fail if no user" do
        get :show, :id => @lead.id
        response.should render_template 'leads/error.html.haml'
      end
    
      it "should show it if the user owns the lead" do
        get :show, :id => @lead.id, :user_id => @user.id
        response.should render_template 'leads/show.html.haml'
      end

      describe "if the user does not own the lead" do
        it "should not show it if the current_user is NOT an admin" do
          get :show, :id => @lead.id, :user_id => @other_id
          response.should render_template 'leads/error.html.haml'
        end
      
        it "should show it if the current_user is a manager"
      
        it "should show it if the current_user is an admin" do
          @user = login_as :admin
          get :show, :id => @lead.id, :user_id => @user.id
          response.should render_template 'leads/show.html.haml'
        end
      end
    
      it "should create an access_lead event" do
        lambda{
          get :show, :id => @lead.id, :user_id => @user.id
        }.should change(UserEvent, :count).by(1)
      end
    end
  end

  describe "call manager" do
    it "should always show lead from the next_in_queue" do
    
    end
  
    it "should serve pool leads" do 
    end
  end

  describe "changes" do
    describe "via adding" do
    end
  
    describe "via updating" do
    end
  
    describe "via deleting" do
    end
  end
end