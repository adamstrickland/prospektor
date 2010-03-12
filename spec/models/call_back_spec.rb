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
    
    describe "ordering within the window" do
      before :each do
        @next = 1.minutes.from_now
        @next_next = @next+1.minute
      end
      
      after :each do
        callbacks = CallBack.window(5.minutes.from_now)
        callbacks.should have(4).items
        callbacks[0].should eql(@first)
        callbacks[1].should eql(@second)
        callbacks[2].should eql(@third)
        callbacks[3].should eql(@fourth)
      end
      
      it "should be ordered by callback date ASC and created at ASC" do
        @first = CallBack.make(:callback_at => @next, :created_at => 1.week.ago)
        @second = CallBack.make(:callback_at => @next, :created_at => 1.days.ago)
        @third = CallBack.make(:callback_at => @next_next, :created_at => 1.year.ago)
        @fourth = CallBack.make(:callback_at => @next_next, :created_at => 1.month.ago)
      end

      it "should be ordered by callback date ASC and created at ASC even if inserts are reversed" do
        @fourth = CallBack.make(:callback_at => @next_next, :created_at => 1.month.ago)
        @third = CallBack.make(:callback_at => @next_next, :created_at => 1.year.ago)
        @second = CallBack.make(:callback_at => @next, :created_at => 1.days.ago)
        @first = CallBack.make(:callback_at => @next, :created_at => 1.week.ago)
      end
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
