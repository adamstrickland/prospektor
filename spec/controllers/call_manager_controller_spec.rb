require 'spec_helper'

describe CallManagerController do  
  describe "if a user has no callbacks" do
  	before :each do
  	end

    it "should show the next lead from their pool" do
    end
    
    it "should show the next untouched lead first"
  end
  
  describe "if a user has callbacks" do
  	before :each do
  	end

    describe "if there are future callbacks" do
    	before :each do
    	end

      it "should show a pool lead if callback is > 3 minutes from now"
    
      describe "if callback is <= 3 minutes from now" do
      	before :each do
      	end

        it "should show the callback lead if there's only one"
        it "should show the older callback lead if there's more than one"
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
        	end

          it "should show a pool lead"
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