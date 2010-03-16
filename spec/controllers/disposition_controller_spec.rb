require 'spec_helper'

describe DispositionController do
  before :each do
    @user = login_as :any
    @lead = mock_model(Lead)
    Lead.stub!(:find).with(any_args()).and_return(@lead)
  end
  
  describe "on new" do
    it "should show the dispo modal" do
      get :new, :lead_id => @lead.id
      assigns[:lead].should eql(@lead)
      response.should render_template 'disposition/new.html.haml'
    end
  end
  
  describe "on create" do
    before :each do
      @lead.should_receive(:save).and_return(true)
      
      # @callback_at_date = 1.year.from_now
      @callback_at_date = Chronic.parse('1 year from now')
      @callback_at = {
        :year => @callback_at_date.year,
        :month => @callback_at_date.month,
        :day => @callback_at_date.day,
        :hour => @callback_at_date.hour,
        :minute => @callback_at_date.min
      }
      @callback_at_string = @callback_at_date.strftime('%m/%d/%Y at %H:%M:%S %p')
    end
    
    describe "the status should be updated" do
      def expect_status(code)
        @lead.should_receive(:status=).with(LeadStatus.find_by_code(code))
      end
      
      describe 'a callback should be created' do
        before :each do
          @callback = mock_model(CallBack)
          CallBack.should_receive(:new).with(hash_including(:callback_at => @callback_at_date)).and_return(@callback)
          
          @callbacks = mock_model(Array)
          @callbacks.should_receive(:<<).with(@callback)
          
          @lead.stub!(:call_backs).and_return(@callbacks)
        end
      
        it "if the status is CB" do
          expect_status('CB')
          post :create, :lead_id => @lead.id, :disposition => 'CB', :callback_at => @callback_at_string, :format => 'json'
        end

        it "if the status is VM" do
          expect_status('VM')
          post :create, :lead_id => @lead.id, :disposition => 'VM', :callback_at => @callback_at_string, :format => 'json'
        end
        
        describe "should also create one using a text field if supplied" do
          # it "or using a datetime picker" do
          #   expect_status('CB')
          #   post :create, :lead_id => @lead.id, :disposition => 'CB', :date => @callback_at, :format => 'json'
          # end
          
          it "if given a wacky datetime string" do
            expect_status('CB')
            
            # for some fucked up reason '1 year from now' run here gives a different date than above...  not exactly encouraging, but...
            callback_at = "364 days from now at #{@callback_at_date.strftime('%H:%M:%S')}"
            
            post :create, :lead_id => @lead.id, :disposition => 'CB', :callback_at => callback_at, :format => 'json'
          end
        end
      end
    
    
      # it "should create a callback if the status is RS" do
      #   @lead.call_backs.should have(0).items
      #   post :create, :lead_id => @lead.id, :disposition => 'RS', :date => @callback_at
      #   @lead.call_backs.should have(1).items
      #   @lead.call_backs.first.callback_at.should eql(cb_at)
      # end
    
      it "should send an email if the status is BS" do
        Notifier.should_receive(:deliver_booked_sale)
        expect_status('CB')
        post :create, :lead_id => @lead.id, :disposition => 'BS', :format => 'json'
      end
    
      it "should otherwise update the status" do
        expect_status('NI')
        post :create, :lead_id => @lead.id, :disposition => 'NI', :date => @callback_at, :format => 'json'
      end
      
      it "should create a comment if a comment is supplied" do
        msg = 'Some message'
        expect_status('NI')
        comment = mock_model(Comment)

        # @lead.should_receive(:comments=).with(comment)
        arr = mock_model(Array)
        @lead.stub!(:comments).and_return(arr)
        arr.should_receive(:<<).with(comment)

        Comment.should_receive(:new).with(any_args()).and_return(comment)
        post :create, :lead_id => @lead.id, :disposition => 'NI', :comments => msg, :format => 'json'
      end
    end
  end
end