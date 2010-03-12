require 'spec_helper'

describe CallManagerController do
  def get_next
    get :next, :user_id => @user.id
    response
  end
  
  def lead_assigned
    assigns[:lead]
  end
  
  def make_callback_at(at=1.minutes.from_now)
    make_callback(:callback_at => at)
  end
  
  def make_callback(opts={})
    CallBack.make({:user => @user, :callback_at => 1.minutes.from_now}.merge(opts))
  end
  
  def stub_callbacks(data)
    near_future_callbacks = data.select{|cb| 
      cb.callback_at >= 0.minutes.ago && cb.callback_at < 4.minutes.from_now
    }.sort{
      |f,l| f.created_at <=> l.created_at
    }
	  @user.stub_chain(:call_backs, :window).and_return(near_future_callbacks)
  end
  
	before :each do
	  @user = login_as :any
	  
	  
	  @past_far = 15.minutes.ago
	  @past_mid = 10.minutes.ago
	  @past_near = 5.minutes.ago
	  @now = 0.minutes.ago
	  @future_near = 1.minutes.from_now
	  @future_far = 10.minutes.from_now
	end

	describe "if a user has no more leads" do
	  it "should go to the end page"
  end
	
	describe "if a user has more leads" do
	  before :each do
	    @leads = (0..2).map{ Lead.make }
	    @user.stub_chain(:leads, :valid).and_return(@leads)
    end
    
  	after :each do
      # response.should render('leads/show.html.haml')
  	end
  	
    describe "if a user has no callbacks" do
    	before :each do
        # @user.stub_chain(:call_backs, :window).and_return([])
        stub_callbacks([])
    	end

      it "should show the next lead from their pool" do
        get_next.should redirect_to(user_lead_url(@user, @leads.first))
      end
    
      it "should show the next untouched lead first"
    end
  
    describe "if a user has callbacks" do
    	before :each do
    	  @callbacks = []
    	end

      describe "if there are future callbacks" do
      	before :each do
      	end

        it "should show a pool lead if callback is > 3 minutes from now" do
          @callbacks << make_callback_at(@future_far)
          stub_callbacks(@callbacks)
          get_next.should redirect_to(user_lead_url(@user, @leads.first))
        end
    
        describe "if callback is <= 3 minutes from now" do
        	before :each do
        	  @callbacks << make_callback_at
        	end

          it "should show the callback lead if there's only one" do
            @callbacks.should have(1).items
            stub_callbacks(@callbacks)
            get_next.should redirect_to(user_lead_url(@user, @callbacks.first.lead))
          end
          
          it "should show the older callback lead if there's more than one" do
            six_months_ago = 6.months.ago
            cb = make_callback(:created_at => six_months_ago, :callback_at => @callbacks.first.callback_at)
            @callbacks << cb
            @callbacks.should have(2).items
            @callbacks.last.should eql(cb)
            @callbacks.first.callback_at.should eql(cb.callback_at)
            @callbacks.first.created_at.should > cb.created_at
            stub_callbacks(@callbacks)
            get_next.should redirect_to(user_lead_url(@user, cb.lead))
          end
        end
      end
    
      describe "if there are past callbacks" do
      	before :each do
      	end

        describe "that are uncalled" do
        	before :each do
        	end

          describe "left over from yesterday" do
          	before :each do
          	  @callbacks << make_callback_at(5.days.ago)
          	end

            it "should show a pool lead" do
              stub_callbacks(@callbacks)
              get_next.should redirect_to(user_lead_url(@user, @leads.first))
            end
          end
        
          describe "from earlier in the day" do
          	before :each do
          	end

            describe "if they were scheduled for between the user's last activity and now" do
            	before :each do
            	end

              it "should show the callbacks' leads in their scheduled_at order before any leads"
            end
        
            describe "if they were scheduled for prior to the user's last activity" do
            	before :each do
            	end

              describe "if their last activity was lead_access" do
              	before :each do
              	end

                it "should show the pool lead"
                it "should take note of the skipped callback"
              end
            
              # describe "if their last activity was login" do
              # end
            
              describe "if their last activity was anything else" do
              	before :each do
              	end

                it "should show the callback lead"
              end
            end
        
            describe "if there are some both prior to and since the user's last activity and now" do
            	before :each do
            	end

              describe "if their last activity was lead_access" do
              	before :each do
              	end

                it "should show the tweener callback lead first"
                it "should show the prior callback lead second"
                it "should show the pool lead third"
              end
            
              # describe "if their last activity was login" do
              # end
            
              describe "if their last activity was anything else" do
              	before :each do
              	end

                it "should show the prior callback lead first"
                it "should show the tweener callback lead second"
                it "should show the pool lead third"
              end
            end
          end
        end
      
        describe "and future callbacks" do
        	before :each do
        	end

          describe "and the past callbacks are uncalled" do
          	before :each do
          	end

            describe "and are left over from yesterday" do
            	before :each do
            	end

              describe "and the future callbacks are > 3 minutes from now" do
              	before :each do
              	end

              end

              describe "and the future callbacks are <= 3 minutes from now" do
              	before :each do
              	end

                describe "and there's only one" do
                	before :each do
                	end

                  it "should show the future callback lead first"
                  it "should show the pool lead second"
                  it "should not show the past callback leads"
                end
              
                describe "and there's more than one" do
                	before :each do
                	end

                  it "should show the first (by create date) future callback lead first"
                  it "should show the next (by create date) future callback lead next"
                  it "should show the pool lead last"
                  it "should not show the past callback leads"
                end
              end
            end

            describe "and are from earlier in the day" do
            	before :each do
            	end

              describe "and the future callbacks are > 3 minutes from now" do
              	before :each do
              	end

                describe "and the past callbacks were scheduled for between last activity and now" do
                	before :each do
                	end

                  describe "if their last activity was lead_access" do
                  	before :each do
                  	end

                    it "should show the past callback first"
                    it "should show the pool lead second"
                  end

                  describe "if their last activity was anything else" do

                  	before :each do

                  	end

                    it "should show the past callback first"
                    it "should show the pool lead second"
                  end
                end

                describe "and the past callbacks were scheduled for before last activity" do
                	before :each do
                	end

                  describe "if their last activity was lead_access" do
                  	before :each do
                  	end

                    it "should show the pool lead first"
                    it "should not show the past callback"
                  end

                  describe "if their last activity was anything else" do
                  	before :each do
                  	end

                    it "should show the past callback first"
                    it "should show the pool lead second"
                  end
                end

                describe "and the past callbacks are some scheduled for both before and between last activity and now" do
                	before :each do
                	end

                  describe "if their last activity was lead_access" do
                  	before :each do
                  	end

                    it "should show the tweener callback first"
                    it "should show the pool lead second"
                    it "should not show the past callback"
                  end

                  describe "if their last activity was anything else" do
                  	before :each do
                  	end

                    it "should show the past callback first"
                    it "should show the tweener callback second"
                    it "should show the pool lead last"
                  end              	
                end
              end
            
              describe "and the future callbacks are <= 3 minutes from now" do
              	before :each do
              	end

                describe "and the past callbacks were scheduled for between last activity and now" do
                	before :each do
                	end

                  describe "if their last activity was lead_access" do
                  	before :each do
                  	end

                    it "should show any future callback leads first"
                    it "should show the tweener callback lead second"
                    it "should show the pool lead last"
                  end

                  describe "if their last activity was anything else" do

                  	before :each do

                  	end

                    it "should show any future callback leads first"
                    it "should show the tweener callback lead second"
                    it "should show the pool lead last"
                  end
                end

                describe "and the past callbacks were scheduled for before last activity" do
                	before :each do
                	end

                  describe "if their last activity was lead_access" do
                  	before :each do
                  	end

                    it "should show any future callback leads first"
                    it "should show the past prior callback lead second"
                    it "should show the pool lead last"
                  end

                  describe "if their last activity was anything else" do
                  	before :each do
                  	end

                    it "should show any future callback leads first"
                    it "should show the past prior callback lead second"
                    it "should show the pool lead last"
                  end
                end

                describe "and the past callbacks are some scheduled for both before and between last activity and now" do
                	before :each do
                	end

                  describe "if their last activity was lead_access" do
                  	before :each do
                  	end

                    it "should show the tweener past callback lead first"
                    it "should show any future callback leads second"
                    it "should show the prior past callback lead third"
                    it "should show the pool lead last"
                  end

                  # describe "if their last activity was login" do
                  # end

                  describe "if their last activity was anything else" do
                  	before :each do
                  	end

                    it "should show any future callback leads second"
                    it "should show the prior past callback lead second"
                    it "should show the tweener callback lead third"
                    it "should show the pool lead last"
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end