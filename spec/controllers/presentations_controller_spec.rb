require 'spec_helper'

describe PresentationsController do
  before :each do
    @user = login_as :any
    
    @preso = mock_model(Presentation)
    Presentation.stub!(:new).and_return(@preso)
    
    @lead = mock_model(Lead)
    Lead.stub!(:find).and_return(@lead)
  end
  
  describe "on GET" do
    before :each do
      
      email = Faker::Internet.email
      @lead.stub!(:email).and_return(email)
      
      @preso.should_receive(:email=).with(email)
    end
    
    it "should render the send invite modal" do
      get :new, :lead_id => @lead.id
      assigns[:presentation].should eql(@preso)
      # assigns[:presentation].email.should eql(@lead.email)
      response.should render_template 'presentations/new.html.haml'
    end
  end
  
  describe "on POST" do
    it "should create an invite for some topic" do
      topic_url = "http://#{Faker::Internet.domain_name}"
      lead_key = Base64.encode64("8885551212").strip
      
      @topic = stub_model(Topic)
      @topic.stub!(:url).and_return(topic_url)
      some_other_email = Faker::Internet.email
      
      @preso.should_receive(:lead=).with(@lead)
      @preso.should_receive(:user=).with(@user)
      @preso.should_receive(:email).and_return(some_other_email)
      @preso.should_receive(:save).and_return(true)
      @preso.should_receive(:topic).and_return(@topic)
      @preso.should_receive(:url=).with("#{topic_url}?key=#{lead_key}")
      
      @lead.should_receive(:email=).with(some_other_email)
      @lead.should_receive(:save).and_return(true)
      @lead.should_receive(:key).and_return(lead_key)
      @lead.should_receive(:status=).with(LeadStatus.find_by_code('INV'))
      
      post :create, :format => 'json', :lead_id => @lead.id, :presentation => { :topic_id => @topic.id, :email => some_other_email }
      
    end
  end
end