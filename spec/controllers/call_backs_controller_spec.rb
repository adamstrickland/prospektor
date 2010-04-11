require 'spec_helper'

describe CallBacksController do
  # def create
  #   respond_to do |format|
  #     format.json do
  #       @callback = CallBack.new
  #       @lead = Lead.find(params[:lead_id])
  #       @user = User.find(params[:user_id])
  #       @callback.lead = @lead
  #       @callback.user = @user
  #       @callback.status = CallBackStatus.find_by_code('UN')
  #       @callback.callback_at = if params[:callback_at].present?
  #         params[:callback_at]
  #       else
  #         lead_tz = TZInfo::Timezone.us_zones.detect{ |z| z.current_period.utc_offset/60/60 == @lead.gmt_offset }
  #         if lead_tz and lead_tz.utc_to_local(Time.now.utc).hour >= 17
  #           # schedule for tomorrow morning 9am in the lead's tz
  #           lead_tz.local_to_utc(Chronic.parse('tomorrow 9am'))
  #         else
  #           3.minutes.from_now
  #         end
  #       end
  #       
  #       if @callback.save
  #         head :ok
  #       else
  #         render :json => @callback.errors, :status => :unprocessable_entity
  #       end
  #     end
  #   end
  # end
  describe 'handle POST /' do
    before :each do
      @lead = mock_model(Lead)
      @lead.stub(:id).and_return(42)
      @user = login_as :any
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
  end
  
  describe 'handle GET /' do
  end
end
