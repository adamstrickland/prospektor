require 'spec_helper'

describe LeadsController do

  def mock_lead(stubs={})
    @mock_lead ||= mock_model(Lead, stubs)
    @mock_lead
  end

  # describe "GET index" do
  #   it "assigns all leads as @leads" do
  #     Lead.stub!(:find).with(:all).and_return([mock_lead])
  #     get :index
  #     assigns[:leads].should == [mock_lead]
  #   end
  # end

  describe "GET show" do
    it "assigns the requested lead as @lead" do
      Lead.stub!(:find).with("37").and_return(mock_lead)
      mock_queue = mock_model(CallQueue)
      CallQueue.stub!(:find).with("123").and_return(mock_queue)
      next_lead = mock_model(Lead)
      mock_queue.stub!(:next_in_queue).with(mock_lead).and_return(next_lead)
      get :show, :id => "37", :call_queue_id => "123"
      # assigns[:lead].should equal(mock_lead)
      assigns[:lead].should == mock_lead
    end
  end

  # describe "GET new" do
  #   it "assigns a new lead as @lead" do
  #     Lead.stub!(:new).and_return(mock_lead)
  #     get :new
  #     assigns[:lead].should equal(mock_lead)
  #   end
  # end
  # 
  # describe "GET edit" do
  #   it "assigns the requested lead as @lead" do
  #     Lead.stub!(:find).with("37").and_return(mock_lead)
  #     get :edit, :id => "37"
  #     assigns[:lead].should equal(mock_lead)
  #   end
  # end

  # describe "POST create" do
  # 
  #   describe "with valid params" do
  #     it "assigns a newly created lead as @lead" do
  #       params = Lead.plan
  #       Lead.stub!(:new).with(params).and_return(mock_lead(:save => true))
  #       post :create, :lead => params
  #       assigns[:lead].should equal(mock_lead)
  #     end
  # 
  #     it "redirects to the created lead" do
  #       Lead.stub!(:new).and_return(mock_lead(:save => true))
  #       post :create, :lead => {}
  #       response.should redirect_to(lead_url(mock_lead))
  #     end
  #   end
  # 
  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved lead as @lead" do
  #       params = Lead.plan
  #       Lead.stub!(:new).with(params).and_return(mock_lead(:save => false))
  #       post :create, :lead => params
  #       assigns[:lead].should equal(mock_lead)
  #     end
  # 
  #     it "re-renders the 'new' template" do
  #       Lead.stub!(:new).and_return(mock_lead(:save => false))
  #       post :create, :lead => {}
  #       response.should render_template('new')
  #     end
  #   end
  # 
  # end
  # 
  # describe "PUT update" do
  # 
  #   describe "with valid params" do
  #     it "updates the requested lead" do
  #       Lead.should_receive(:find).with("37").and_return(mock_lead)
  #       mock_lead.should_receive(:update_attributes).with({'these' => 'params'})
  #       put :update, :id => "37", :lead => {:these => 'params'}
  #     end
  # 
  #     it "assigns the requested lead as @lead" do
  #       Lead.stub!(:find).and_return(mock_lead(:update_attributes => true))
  #       put :update, :id => "1"
  #       assigns[:lead].should equal(mock_lead)
  #     end
  # 
  #     it "redirects to the lead" do
  #       Lead.stub!(:find).and_return(mock_lead(:update_attributes => true))
  #       put :update, :id => "1"
  #       response.should redirect_to(lead_url(mock_lead))
  #     end
  #   end
  # 
  #   describe "with invalid params" do
  #     it "updates the requested lead" do
  #       Lead.should_receive(:find).with("37").and_return(mock_lead)
  #       mock_lead.should_receive(:update_attributes).with({'these' => 'params'})
  #       put :update, :id => "37", :lead => {:these => 'params'}
  #     end
  # 
  #     it "assigns the lead as @lead" do
  #       Lead.stub!(:find).and_return(mock_lead(:update_attributes => false))
  #       put :update, :id => "1"
  #       assigns[:lead].should equal(mock_lead)
  #     end
  # 
  #     it "re-renders the 'edit' template" do
  #       Lead.stub!(:find).and_return(mock_lead(:update_attributes => false))
  #       put :update, :id => "1"
  #       response.should render_template('edit')
  #     end
  #   end
  # 
  # end
  # 
  # describe "DELETE destroy" do
  #   it "destroys the requested lead" do
  #     Lead.should_receive(:find).with("37").and_return(mock_lead)
  #     mock_lead.should_receive(:destroy)
  #     delete :destroy, :id => "37"
  #   end
  # 
  #   it "redirects to the leads list" do
  #     Lead.stub!(:find).and_return(mock_lead(:destroy => true))
  #     delete :destroy, :id => "1"
  #     response.should redirect_to(leads_url)
  #   end
  # end

end
