require 'spec_helper'

describe DispositionController do
  before :each do
    @user = login_as :any
    @user.stub(:complete_callbacks!).and_return(true)
    @lead = mock_model(Lead)
    @lead.stub(:update_status!).and_return(true)
    Lead.stub!(:find).with(any_args()).and_return(@lead)
    
    @lead.stub(:disposition!).with(any_args()).and_return(true)
  end
  
  describe "on GET" do
    it "should show the dispo modal" do
      get :new, :lead_id => @lead.id
      assigns[:lead].should eql(@lead)
      response.should render_template 'disposition/new.html.haml'
    end
  end
  
  describe "on POST" do
    before :each do
      # @callback_at_date = 1.year.from_now
      @callback_at_date = Chronic.parse('1 year from now')
      @callback_at = {
        :year => @callback_at_date.year,
        :month => @callback_at_date.month,
        :day => @callback_at_date.day,
        :hour => @callback_at_date.hour,
        :minute => @callback_at_date.min
      }
      # @callback_at_string = @callback_at_date.strftime('%m/%d/%Y at %H:%M:%S %p')
      # @callback_at_string = @callback_at_date.to_s # '%a %b %d %H:%M:%S %Z %Y'
      @callback_at_string = @callback_at_date.gmtime.strftime('%Y-%m-%d %H:%M:%SZ')
    end
    
    it "should not double-insert the comment on a dispo"
     
      
    it "should translate the date correctly" do
      @lead = Lead.make_unsaved
      @lead.should be_valid
      @lead.save
      Lead.stub!(:find).with(any_args()).and_return(@lead)
      @lead.stub!(:owner).and_return(@user)
      post :create, :lead_id => @lead.id, :disposition => 'CB', :callback_at => @callback_at_string, :format => 'json'
      # assigns[:callback].should_not be_nil
      # assigns[:callback].callback_at.hour.should eql @callback_at[:hour]
    end
    
    describe "the status should be updated" do
      before :each do
        @lead.stub(:save).and_return(true)
        @callbacks = mock_model(Array)
        # @lead.should_receive(:call_backs).and_return(@callbacks)
      end
      
      def expect_status(code)
        # @lead.should_receive(:status=).with(LeadStatus.find_by_code(code))
      end 
      
      describe 'a callback should be created' do
        before :each do
          @callback = mock_model(CallBack)
          # CallBack.should_receive(:new).with(hash_including(:callback_at => @callback_at_date.gmtime.strftime('%Y-%m-%d %H:%M:%SZ'))).and_return(@callback)
          
          # @callbacks.should_receive(:<<).with(@callback)
          # @lead.should_receive(:disposition!).and_return(true)
          @lead.should_receive(:disposition!).with(@user, hash_including()).and_return(true)
        end
      
        it "if the status is CB" do
          expect_status('CB')
          post :create, :lead_id => @lead.id, :disposition => 'CB', :callback_at => @callback_at_string, :format => 'json'
          # assigns[:callback].should_not be_nil
        end

        it "if the status is VM" do
          expect_status('VM')
          post :create, :lead_id => @lead.id, :disposition => 'VM', :callback_at => @callback_at_string, :format => 'json'
          # assigns[:callback].should_not be_nil
        end  
      end
      
      
      # describe "should also create one using a text field if supplied" do
      #   # it "or using a datetime picker" do
      #   #   expect_status('CB')
      #   #   post :create, :lead_id => @lead.id, :disposition => 'CB', :date => @callback_at, :format => 'json'
      #   # end
      #   
      #   it "if given a wacky datetime string" do
      #     @callback = mock_model(CallBack)
      #     CallBack.should_receive(:new).with(hash_including(:callback_at => @callback_at_date.gmtime.strftime('%Y-%m-%d %H:%M:%SZ'))).and_return(@callback)
      #     
      #     @callbacks.should_receive(:<<).with(@callback)
      #     
      #     expect_status('CB')
      #     
      #     # for some fucked up reason '1 year from now' run here gives a different date than above...  not exactly encouraging, but...
      #     callback_at = "364 days from now at #{@callback_at_date.strftime('%H:%M:%S')}"
      #     
      #     post :create, :lead_id => @lead.id, :disposition => 'CB', :callback_at => callback_at, :format => 'json'
      #     assigns[:callback].should_not be_nil
      #   end
      # end
      
      it "if no date provided, use tomorrow" do
        # callback = mock_model(CallBack)
        # CallBack.should_receive(:new).with(hash_including(:callback_at => Chronic.parse('tomorrow at 9am'))).and_return(callback)
        # callbacks = mock_model(Array)
        # callbacks.should_receive(:<<).with(callback)
        # @lead.should_receive(:call_backs).and_return(callbacks)
        # @lead.should_receive(:disposition!).and_return(true)
        @lead.should_receive(:disposition!).with(@user, hash_including({:disposition => 'VM'})).and_return(true)
        expect_status('VM')
        post :create, :lead_id => @lead.id, :disposition => 'VM', :format => 'json'
      end
    
      # it "should create a callback if the status is RS" do
      #   @lead.call_backs.should have(0).items
      #   post :create, :lead_id => @lead.id, :disposition => 'RS', :date => @callback_at
      #   @lead.call_backs.should have(1).items
      #   @lead.call_backs.first.callback_at.should eql(cb_at)
      # end
    
      it "should send an email if the status is BS" do
        @lead.should_receive(:disposition!).with(@user, hash_including({:disposition => 'BS'})).and_return(true)
        # Notifier.should_receive(:deliver_booked_sale)
        expect_status('CB')
        post :create, :lead_id => @lead.id, :disposition => 'BS', :format => 'json'
      end
    
      LeadStatus.all.reject{|s| ['CB','BS','VM'].include?(s.code)}.each do |ls|
        it "should otherwise update the status as #{ls.code}" do
          expect_status(ls.code)
          post :create, :lead_id => @lead.id, :disposition => ls.code, :date => @callback_at, :format => 'json'
        end
      end
      
      it "should create a comment if a comment is supplied" do
        msg = 'Some message'
        expect_status('NI')
        comment = mock_model(Comment)

        # @lead.should_receive(:comments=).with(comment)
        # arr = mock_model(Array)
        # @lead.stub!(:comments).and_return(arr)
        # arr.should_receive(:<<).with(comment)

        # Comment.should_receive(:new).with(any_args()).and_return(comment)
        @lead.should_receive(:disposition!).with(@user, hash_including({:disposition => 'NI'})).and_return(true)
        post :create, :lead_id => @lead.id, :disposition => 'NI', :comments => msg, :format => 'json'
      end
    end
  end
end