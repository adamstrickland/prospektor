require 'spec_helper'

describe CallBacksController do
  describe 'handle POST /' do
    before :each do
      @lead = mock_model(Lead)
      @lead.stub(:id).and_return(42)
      @user = mock_user :any
      @params = {
        :lead_id => @lead.id,
        :user_id => @user.id
      }
    end
    
    it "should reject an html request" do
      post :create, { :format => 'html' }.merge(@params)
      response.should_not be_success
    end
    
    describe "should accept a json request" do
      describe "should try to create a callback" do
        before :each do
          @cb_status = mock_model(CallBackStatus)
          @cb_status.stub(:id).and_return(876)
          CallBackStatus.should_receive(:find_by_code).with('UN').and_return(@cb_status)
          Lead.should_receive(:find).and_return(@lead)
          @lead.should_receive(:gmt_offset).and_return(-5)
          [@cb_status, @lead].each do |m|
            m.stub(:destroyed?).and_return(false)
          end
        end
      
        it "should create a callback for 3 minutes from now" do
          safe_time = Chronic.parse('today 9am')
          Time.should_receive(:now).any_number_of_times.and_return(safe_time)
          post :create, {:format => 'json'}.merge(@params)
          assigns[:callback].should_not be_nil
          assigns[:callback].callback_at.should be_close(3.minutes.from_now, 2.minutes)
          response.should be_success
        end

        it "should create a callback for tomorrow at 9am" do
          safe_time = Chronic.parse('today 6pm')
          Time.should_receive(:now).any_number_of_times.and_return(safe_time)
          post :create, {:format => 'json'}.merge(@params)
          assigns[:callback].should_not be_nil
          # assigns[:callback].callback_at.should be_close(Chronic.parse('tomorrow 9am'), 2.minutes)
          assigns[:callback].callback_at.utc.should eql Chronic.parse('tomorrow 8am').utc
          response.should be_success
        end
      end
    end
  end
  
  describe 'handle PUT /:id' do
    before :each do
      @user = login_as :any
      @callback = mock_model(CallBack)
      CallBack.should_receive(:find).with(any_args()).and_return(@callback)
    end
    
    it "should interpret the date correctly" do
      # date_as_text = "Thu Apr 22 2010 09:43:40 GMT-0500 (CDT)"
      date_as_text = "2010-04-22T09:43:40-0500"
      @callback.should_receive(:callback_at=).with(date_as_text)
      @callback.should_receive(:save).and_return(true)
      # post :update, :format => 'json', :method => '_put', :id => @callback.id, :callback_at => date_as_text
      put :update, :format => 'json', :id => @callback.id, :callback_at => date_as_text
      params[:id].should eql @callback.id.to_s
      params[:callback_at].should eql date_as_text
    end
  end
  
  describe 'handle GET /' do
  end
end
