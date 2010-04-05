require 'spec_helper'

describe SearchController do
  describe "GET /index" do
    before :each do
      @leads = (0..4).map{ |i| 
        l = stub_model(Lead)
        l
      }
    end
    
    it "should find leads for search"
    
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