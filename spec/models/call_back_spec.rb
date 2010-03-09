require 'spec_helper'

describe CallBack do
  before :each do
    cb = LeadStatus.find_by_code('CB')
    CallBack.make(:callback_at => 2.days.ago, :lead => Lead.make(:status => cb))
    CallBack.make(:callback_at => 2.days.from_now, :lead => Lead.make(:status => cb))
    CallBack.make(:callback_at => 10.days.from_now, :lead => Lead.make(:status => cb))
  end
  
  describe "should return all the callbacks in the given window" do
    before :each do
    end
    
    it "for this week, specified" do
      CallBack.window(1.week.from_now, Date.today).should have(1).items
    end
    
    it "for this week, not specified" do
      CallBack.window(1.week.from_now).should have(1).items
    end
    
    it "for next week, specified" do
      CallBack.window(2.week.from_now, 1.week.from_now).should have(1).items
    end
  end
  
  describe "should handle stale callbacks" do
    it "should show the callbacks that weren't acted upon" do
      CallBack.stale.should have(1).items
    end
  
    # it "should stack the stale callbacks into today's schedule" do
    # end
  end
end
