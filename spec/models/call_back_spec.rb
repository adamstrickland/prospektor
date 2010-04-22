require 'spec_helper'

describe CallBack do
  before :each do
    cb = LeadStatus.find_by_code('CB')
    @callback_times = [2.days.ago, 2.days.from_now, 10.days.from_now]
    @callbacks = @callback_times.map do |t|
      CallBack.make(:callback_at => t, :lead => Lead.make(:status => cb))
    end
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
  
  describe "should return all uncalled callbacks" do
    it "when asked" do
      CallBack.uncalled.should have(@callbacks.count).items
    end
    
    it "should filter out leads once they've been called'" do
      callback = @callbacks.first
      lead = callback.lead
      # lead.updated_at.should <= callback.updated_at
      # lead.sic_code_9 = '12345' # do something so that the save occurs
      # 
      # Lead.should_receive(:after_save)
      # lead.save!
      # lead.updated_at.should > callback.updated_at
      
      complete = CallBackStatus.complete
      callback.status = complete
      callback.save!
      
      callback.status.should eql(complete)
      
      uncalled = CallBack.uncalled
      uncalled.should_not include(callback)
      uncalled.each do |cb|
        cb.status.should_not eql(complete)
      end
      
      uncalled.should have(@callbacks.count - 1).items
      uncalled.map{|cb| cb.lead}.should_not include(lead)
    end
  end
  
  describe "date handling" do
    before :each do
      @callback = CallBack.new
    end
    
    describe "when updating" do
      before :each do
        @user = mock_user :any
        @lead = mock_model(Lead)
        @callback.callback_at = 1.month.from_now
        @callback.lead = @lead
        @callback.user = @user
        @callback.save.should be_true
      end
      
      describe "should update nicely with a date from FullCalendar" do
        after :each do
          @callback.should be_valid
          @callback.save.should be_true
          @expected = CallBack.find(@callback.id)
          d = @expected.callback_at.localtime
          d.year.should eql 2010
          d.month.should eql 4
          d.day.should eql 22
          d.hour.should eql 9
          d.min.should eql 43
          d.sec.should eql 40
        end
        
        it "with time at zulu" do
          @callback.callback_at = "2010-04-22T14:43:40Z"
        end
        
        it "with time at local" do
          @callback.callback_at = "2010-04-22T09:43:40-0500"
        end
      end
    end
  end
end
