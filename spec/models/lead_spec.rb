require 'spec_helper'

describe Lead do
  describe "should get filtered when" do
    before(:each) do
      # fixtures :states, :time_zones
      
      State.all.each do |s|
        Lead.make(:state => s.abbrev)
      end
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
          # Lead.located_in_timezone_of(st).count.should eql(State.all.select{|s| s.time_zone == timezone}.count)
          Lead.located_in_timezone_of(st).count.should eql(2601)
        end
      end
      
      it "when using state as model" do
        @scenarios.each do |tz, st|
          state = State.find_by_state(st)
          state.should_not be_nil
          timezone = TimeZone.find_by_time_zone(tz)
          timezone.should_not be_nil
          # Lead.located_in_timezone_of(state).count.should eql(State.all.select{|s| s.time_zone == timezone}.count)
          Lead.located_in_timezone_of(state).count.should eql(2601)
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
            Lead.make(:status => Status.find_by_code('DSC'))
          end
        end
        
        it "shouldn't make a difference" do
          Lead.valid.count.should eql(State.all.count)
        end
      
        it "will make a difference if some are not" do
          how_many = 10
          how_many.times do
            Lead.make(:status => Status.find_by_code('NA'))
          end
          Lead.valid.count.should eql(State.all.count + how_many)
        end
      end
    end
       
    describe "that are not" do
      it "owned by someone else" do
        e = Employee.make
        u = User.make(:employee => e)
        Lead.make(:users => [u])
        Lead.open.count.should eql(State.all.count)
      end
      
      it "already a client" do
        Sale.make(:appointment => Schedule.make(:contact => Contact.make(:lead => Lead.make)))
        Lead.open.count.should eql(State.all.count)
      end
    end
    
    # it "that are not already clients"
    # 
    # it "are scheduled for callback"
  end
end
