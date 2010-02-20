require 'spec_helper'

describe Lead do
  describe "should get filtered when" do
    before(:each) do
      # fixtures :states, :time_zones
      
      State.all.each do |s|
        Lead.make(:state => s.abbrev)
      end
      @lead_count = 2601
    end
    
    describe "located in the same state" do
      before do
        @tx = 'TX'
        @texas = State.find_by_state(@tx)
        @texas.should_not be_nil
      end
      
      it "when using state as string" do
        Lead.located_in_state_of(@tx).count.should eql(1)
      end
      
      it "when using state as model" do
        Lead.located_in_state_of(@texas).count.should eql(1)
      end
    end
    
    describe "located in the same timezone" do
      before do
        @scenarios = {
          'E' => 'ME',
          'C' => 'TX',
          'M' => 'CO',
          'P' => 'CA',
          'A' => 'AL',
          'H' => 'HI'
        }
      end
      
      it "when using state as string" do
        @scenarios.each do |tz, st|
          State.find_by_state(st).should_not be_nil
          timezone = TimeZone.find_by_time_zone(tz)
          timezone.should_not be_nil
          Lead.located_in_timezone_of(st).count.should eql(@lead_count)
        end
      end
      
      it "when using state as model" do
        @scenarios.each do |tz, st|
          state = State.find_by_state(st)
          state.should_not be_nil
          timezone = TimeZone.find_by_time_zone(tz)
          timezone.should_not be_nil
          Lead.located_in_timezone_of(state).count.should eql(@lead_count)
        end
      end
    end
    
    describe "that are not dead" do
      it "if all statuses are null" do
        Lead.valid.count.should eql(State.all.count)
      end
      
      describe "if some statuses have a dead state" do
        before do
          50.times do
            Lead.make(:status => LeadStatus.find_by_code('DSC'))
          end
        end
        
        it "shouldn't make a difference" do
          Lead.valid.count.should eql(State.all.count)
        end
      
        it "will make a difference if some are not" do
          how_many = 10
          how_many.times do
            Lead.make(:status => LeadStatus.find_by_code('NA'))
          end
          Lead.valid.count.should eql(State.all.count + how_many)
        end
      end
    end
       
    describe "that are not" do
      before do
        @no_change = State.all.count
        @one_more = @no_change+1
      end
      
      it "owned by someone else that's an active employee" do
        Lead.make(:users => [User.make(:employee => Employee.make)])
        
        Lead.unsold.should have(@one_more).items
        Lead.vacant.should have(@no_change).items
        Lead.open.should have(@no_change).items
      end

      it "owned by someone else that isn't an active employee" do
        Lead.make(:users => [User.make(:employee => Employee.make(:inactive))])
        
        Lead.unsold.should have(@one_more).items
        Lead.vacant.should have(@one_more).items
        Lead.open.should have(@one_more).items
      end
      
      it "already a client" do
        Sale.make(:appointment => Schedule.make(:contact => Contact.make(:lead => Lead.make)))
        
        Lead.unsold.should have(@no_change).items
        Lead.vacant.should have(@one_more).items
        Lead.open.should have(@no_change).items
      end
      
      it "owned by an active employee plus already a client" do
        Lead.make(:users => [User.make(:employee => Employee.make)])
        Sale.make(:appointment => Schedule.make(:contact => Contact.make(:lead => Lead.make)))
        
        Lead.unsold.should have(@one_more).items
        Lead.vacant.should have(@one_more).items
        Lead.open.should have(@no_change).items
      end
    end
    
    # it "that are not already clients"
    # 
    # it "are scheduled for callback"
  end
end
