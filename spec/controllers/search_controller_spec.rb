require 'spec_helper'

describe SearchController do
  def do_get(options={})
    options[:format] ||= 'ajax'
    get :index, options
  end
  
  def do_search(term)
    term.should_not be_nil
    term.should_not be_empty
    do_get :search => term
    params[:search].should eql term
    response.should render_template 'search/index.ajax.haml'
  end
  
  describe "GET /index" do
    before :each do
      @leads = (0..4).map{ |i| 
        l = stub_model(Lead)
        l
      }
      @matching_leads = @leads[0..1]
      @search_term = 'kawabunga'
    end
    
    describe "results should be filtered" do
      before :each do
        @other_user = mock_user
      end
      
      describe "if the user is an admin" do
        before :each do
          @user = login_as :admin
        end
        
        it "should pull from all leads" do
          Lead.should_receive(:searchy).with(@search_term).and_return(@matching_leads)
          # Lead.should_receive(:paginate).and_return(@matching_leads)
          do_search @search_term
          assigns[:leads].should eql @matching_leads
        end
      end
      
      describe "if the user is not an admin" do
        before :each do
          @user = login_as :any
          @user_leads = @leads[1..3]
          @user.should_receive(:leads).and_return(@user_leads)
        end
        
        it "should only show leads that belong to the user" do
          @user_leads.should_receive(:searchy).with(@search_term).and_return([@leads[1]])
          do_search @search_term
          assigns[:leads].should eql [@leads[1]]
        end
      end
    end
      
    # it "should find leads for search" do
    #   search_str = 'something'
    #   Lead.should_receive(:conditions_by_like).with(search_str).and_return("1=1")
    #   Lead.should_receive(:paginate).and_return(@leads)
    #   get :index, :format => 'ajax', :search => search_str
    #   params[:search].should_not be_blank
    #   assigns[:leads].should be @leads
    #   response.should render_template 'search/index.ajax.haml'
    # end
  end
end