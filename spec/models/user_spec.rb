require 'spec_helper'

class Array
    def map_with_index!
       each_with_index do |e, idx| self[idx] = yield(e, idx); end
    end

    def map_with_index(&block)
        dup.map_with_index!(&block)
    end
end

# has_and_belongs_to_many :roles
# has_and_belongs_to_many :leads
# alias_attribute :assignments, :leads
# has_many :presentations
# has_many :appointments
# has_many :events
# has_many :comments
# has_many :call_queues
# belongs_to :employee
# validates_length_of :phone, :maximum => 10
# validates_length_of :mobile, :maximum => 10, :allow_nil => true

# def is_admin?
# def official_phone
# def callbacks
# def login=(value)
# def email=(value)
# def ready_leads(amount=0)
# def name
# def self.generate_password(size=8)

describe User do
  before :each do
    @user = User.make
  end
  
  describe "propeties" do
    before :each do
      @leads = (1..5).map{ 
        l = mock_model(Lead)
        l.stub!(:destroyed?).and_return(false)
        l.stub!(:quoted_id).and_return(l.id.to_s)
        # l.stub!(:employee_id).and_return(true)
        l.stub!(:has_attribute?).with(anything()).and_return(true)
        l.stub!(:[]).with(anything()).and_return([])
        l
      }
      @user.leads = @leads
      @user.leads.should have(@leads.count).items
    end

    it "should always have a lower-case login" do
      login = 'ASMITH'
      @user.login = login
      @user.login.should eql(login.downcase)
    end

    it "should always have a lower-case email address" do
      email = 'ThisIsTheEnd@TheWorld.UK'
      @user.email = email
      @user.email.should eql(email.downcase)
    end

    it "should generate a random password" do
      pwd_size = 8
      10.times do
        pwd1 = User.generate_password(pwd_size)
        pwd1.length.should eql(pwd_size)
        pwd2 = User.generate_password
        pwd2.length.should eql(pwd_size)
        pwd1.should_not eql(pwd2)
      end
    end
  
    describe "should return a phone number" do
      before :each do
        @trigon = "214-361-0080"
        @user.phone = @trigon.gsub(/-/, "")
      end
    
      it "should be trigon's phone number" do
        @user.extension = nil
        @user.official_phone.should eql(@trigon)
      end
    
      it "should have their extension when available" do
        @user.extension = "1234"
        @user.official_phone.should eql("#{@trigon} x1234")
      end
    end
  
    describe "should indicate if the user is an admin" do
      before :each do
        # fixtures :roles
      end
    
      it "should be true if they have the admin role" do
        @user.roles << Role.find_by_title('admin')
        @user.roles.should have(1).items
        @user.is_admin?.should be_true
      end
    
      it "should be false if they don't have the admin role" do
        @user.is_admin?.should be_false
        @user.roles = Role.all.reject{|r| r.title == 'admin' }
        @user.is_admin?.should be_false
      end
    end
  
    describe "should return a list of leads" do
      before :each do
        @date = Date.today
        @leads.each_with_index{ |l,i|
          l.should_receive(:status).at_least(:once).and_return(nil)
        }
        @user.leads.select{|l| l.status.blank? }.should have(@leads.count).items
        @user.leads.select{|l| l.status.present? and l.status.state == 'assigned' }.should have(0).items
      
        @bad_leads = [@leads[2]]
        @good_leads = @leads[0..1] + @leads[3..-1]
      end
    
      it "when none of them has :updated_at.nil?" do
        @leads.each_with_index{ |l,i|
          l.should_receive(:updated_at).any_number_of_times.and_return(@date - i)
        }
        @user.leads.select{|l| l.updated_at.blank? }.should have(0).items
        @results = @user.ready_leads
        @results.should have(@leads.count).items
        @results[0].updated_at.should eql(@date - (@leads.count - 1))
        @results[-1].updated_at.should eql(@date)
      end

      it "when some of them has :updated_at.nil?" do
        @good_leads.each_with_index{ |l,i|
          l.should_receive(:updated_at).any_number_of_times.and_return(@date - i)
        }
        @bad_leads.each_with_index{ |l,i|
          l.should_receive(:updated_at).any_number_of_times.and_return(nil)
        }
        @user.leads.select{|l| l.updated_at.blank? }.should have(@bad_leads.count).items
        @user.leads.select{|l| l.updated_at.present? }.should have(@good_leads.count).items
        @results = @user.ready_leads
        @results.should have(@leads.count).items
        @results[0].updated_at.should eql(@good_leads.last.updated_at)
        @results[-2].updated_at.should eql(@good_leads.first.updated_at)
        @results[-1].updated_at.should eql(nil)
      end
    end
  end
  
  describe "when getting the next lead for the user" do    
    # def next_lead_in_queue
    #   if self.call_backs.present? and (uncalled = self.call_backs.window(3.minutes.from_now, Chronic.parse("#{Date.today} 12:00am")).uncalled)
    #     uncalled.sort_by{ |f,l|
    #       [f.callback_at, f.created_at] <=> [l.callback_at, l.created_at]
    #     }.first.lead
    #   else
    #     self.leads.ready.first
    #   end
    # end
    before :each do
      @leads = (1..5).map{|i| Lead.make }
      @user.leads = @leads
      @user.save
    end
    
    describe "should return a pool lead" do
      it "if there are no callbacks" do
        lead = @user.next_lead_in_queue
        lead.should eql(@leads.first)
      end
      
      it "if there are no past callbacks from today" do
        cb = CallBack.make(:user => @user, :lead => @leads.last, :callback_at => 1.days.ago)
        lead = @user.next_lead_in_queue
        lead.should eql(@leads.first)
      end
      
      describe "ordered by" do
        it "should sort the leads by status, then by last upd date" do
          statused_leads = @leads[0..-2].map_with_index do |l,i|
            l.status = LeadStatus.skip
            # l.updated_at = i.days.ago
            l.save!
          end
          # @user.pool.map{|l| l.id}.should eql([4,3,2,1,0].map{|i| @leads[i].id})
          @user.pool.map{|l| l.id}.should eql([4,0,1,2,3].map{|i| @leads[i].id})
        end
        
        it "should show the empty status leads at the top" do
          statused_leads = @leads[0..-2].map do |l|
            l.status = LeadStatus.skip
            l.save!
          end
          lead = @user.next_lead_in_queue
          statused_leads.should_not include(lead)
        end
      end
    end
    
    describe "should return the callback lead" do
      it "if there is an uncalled callback from earlier today" do
        cb = CallBack.make(:user => @user, :lead => @leads.last, :callback_at => 1.minutes.ago)
        lead = @user.next_lead_in_queue
        lead.should eql(@leads.last)
      end
      
      describe "if there is more than one uncalled callback from earlier today" do
        before :each do
          @callback_leads = (3..4).map{|i| @leads[i] }
          
          @callbacks = @callback_leads.map_with_index do |l, i|
            CallBack.make(:user => @user, :lead => l, :callback_at => i.minutes.ago)
          end
          
          # @callbacks = @callback_leads.map{|l| CallBack.make(:user => @user, :lead => l, :callback_at => i.minutes.ago) }
        end
      
        it "should return the oldest callback first" do
          lead = @user.next_lead_in_queue
          lead.should eql(@callbacks.last.lead)
        end
      
        it "should return all the callback leads before any pool leads" do
          lead1 = @user.next_lead_in_queue
          @callback_leads.should include(lead1)
          lead1.save
          lead2 = @user.next_lead_in_queue
          lead2.should_not eql(lead1)
          @callback_leads.should include(lead2)
          lead2.save
          lead3 = @user.next_lead_in_queue
          lead3.should_not eql(lead1)
          lead3.should_not eql(lead2)
          @callback_leads.should_not include(lead3)
          # lead.should eql(@callbacks.last.lead)
        end
        
        it "should return the callback created first if callback times are the same" do
          cbs = (3..4).map{|i| CallBack.make(:user => @user, :lead => @leads[i], :callback_at => 1.minutes.ago) }
          cbs.last.created_at = 3.months.ago
          lead = @user.next_lead_in_queue
          lead.should eql(cbs.last.lead)
        end
      end
      
      describe "if there is a callback less than 3 minutes from now" do
        before :each do
          @callback = CallBack.make(:user => @user, :lead => @leads[2], :callback_at => 1.minutes.from_now)
        end
        
        it "if there are no other callbacks, return the near one" do
          lead = @user.next_lead_in_queue
          lead.should eql(@callback.lead)
        end
        
        it "should return past callbacks before the future ones" do
          past_callbacks = (3..4).map{|i| CallBack.make(:user => @user, :lead => @leads[i], :callback_at => 1.minutes.ago) }
          @user.next_lead_in_queue.should eql(@leads[3])
          @leads[3].save!
          @user.next_lead_in_queue.should eql(@leads[4])
          @leads[4].save!
          @user.next_lead_in_queue.should eql(@leads[2])
          @leads[2].save!
          @user.next_lead_in_queue.should eql(@leads[0])
          @leads[0].status = LeadStatus.no_interest
          @leads[0].save!
          @user.next_lead_in_queue.should eql(@leads[1])
          
          # order = (1..@leads.count).map do |i|
          #             l = @user.next_lead_in_queue
          #             # l.sic_code_9 = '12345'
          #             l.save
          #             l
          #           end
          #           order.map{|l| l.id}.should eql([@leads[3], @leads[4], @leads[2], @leads[0], @leads[1]].map{|l| l.id})
        end
      end
    end
  end
end