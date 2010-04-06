require 'spec_helper'

describe Lead do
  describe "search" do
    before :each do
      Lead.make(:phone => "2145551212", :first_name => 'Bill', :last_name => 'Smith', :company => 'SmithCo', :zip => 75201)
      Lead.make(:phone => "9725551212", :first_name => 'Bill', :last_name => 'Jones', :company => 'Jones, Inc', :zip => 75202)
      Lead.make(:phone => "5128886754", :first_name => 'John', :last_name => 'Davis', :company => 'Davis Widgets, LLC', :zip => 75203)
    end
    
    describe "using find_by_like" do
      it "should find leads by phone number" do
        Lead.find_by_like(800).should have(0).items
        Lead.find_by_like(214).should have(1).items
        Lead.find_by_like(512).should have(3).items
        Lead.find_by_like(5551212).should have(2).items
        Lead.find_by_like("5551212").should have(2).items
        Lead.find_by_like(2145551212).should have(1).items
        # Lead.find_by_like("555-1212").should have(1).items
      end
    
      it "should find leads by prospect name" do
        Lead.find_by_like('Bill').should have(2).items
        Lead.find_by_like('Jones').should have(1).items
        # Lead.find_by_like('Bill Jones').should have(1).items
        Lead.find_by_like('Jo').should have(2).items
        Lead.find_by_like('John').should have(1).items
      end
    
      it "should find leads by zip" do
        Lead.find_by_like(75203).should have(1).items
        Lead.find_by_like(75204).should have(0).items
        Lead.find_by_like(752).should have(3).items
      end
    
      it "should find leads by company name" do
        Lead.find_by_like('LLC').should have(1).items
        Lead.find_by_like('Corp').should have(0).items
        Lead.find_by_like(',').should have(2).items
      end
    end
    
    describe "using searchy" do    
      it "should work using searchy, too" do
        Lead.searchy(214).should have(1).items
        Lead.searchy(512).should have(3).items
        Lead.searchy('Bill').should have(2).items
        Lead.searchy(75203).should have(1).items
        Lead.searchy('LLC').should have(1).items
        Lead.searchy(',').should have(2).items
      end
    end
  end
  
  describe "scoped" do 
    describe "by status" do
      before :each do
        #create one for each status, plus one w/ a NULL status
        LeadStatus.all.each do |ls|
          Lead.make(:status => ls)
        end
        Lead.make(:status => nil)
        @all = Lead.count
      end
    
      it "should have some valid" do
        Lead.valid.should have(5).items
      end
      
      it "should have some invalid" do
        Lead.invalid.should have(9).items
      end
    
      it "should have some dead" do
        Lead.dead.should have(5).items
      end
      
      # it "should have some alive" do
      #   Lead.alive.should have(9).items
      # end
    
      it "should have some claimed" do
        Lead.claimed.should have(2).items
      end
      
      it "should have some unclaimed" do
        Lead.unclaimed.should have(12).items
      end
    
      it "should have some suspended" do
        Lead.suspended.should have(2).items
      end 
      
      it "should have some unsuspended" do
        Lead.unsuspended.should have(12).items
      end

      describe "in combination with other data points" do
        before :each do
          # @lead = Lead.valid.first
        end
        
        it "should also check the state for validity" do
          lambda{
            Lead.make(:status => nil, :state => 'XX')
          }.should_not change(Lead.valid, :count)
        end
        
        it "should have unclaimed if not already a contact" do
          lambda{
            Contact.make(:lead => Lead.make(:status => LeadStatus.find_by_state('assigned')))
          }.should_not change(Lead.unclaimed, :count)
          
          lambda{
            Contact.make(:lead => Lead.unclaimed.first)
          }.should change(Lead.unclaimed, :count).by(-1)
        end
        
        it "should filter out leads that are already clients" do
          lambda{
            @client = Contact.make(:lead => Lead.unclaimed.first)
          }.should_not change(Lead.client, :count)
          
          lambda{
            Schedule.make(:contact => @client)
          }.should change(Lead.client, :count).by(1)
        end
        
        describe "should filter out leads that are already owned" do
          describe "by active employees" do
            before :each do
              @zaphod = User.make(:employee => Employee.make)
            end
            
            it "as held" do
              lambda{
                @zaphod.leads << Lead.unclaimed.first
                @zaphod.save
              }.should change(Lead.held, :count).by(1)
            end
            
            it "as vacant" do
              lambda{
                @zaphod.leads << Lead.unclaimed.first
                @zaphod.save
              }.should change(Lead.vacant, :count).by(-1)
            end
          end
          
          it "but not by inactive employees" do
            @trillian = User.make(:employee => Employee.make(:inactive))
            lambda{
              @trillian.leads << Lead.unclaimed.first
              @trillian.save
            }.should_not change(Lead.held, :count)
          end
        end
        
        it "should filter out sold leads" do
          @lead = Lead.unclaimed.first
          # @lead = stub_model(Lead)
          # @lead.stub(:full_name).and_return("#{Faker::Name.first_name} #{Faker::Name.last_name}")
          @client = Contact.make(:lead => @lead)
          @user = mock_user
          @user.stub(:official_phone).and_return(Faker::PhoneNumber.phone_number)
          lambda{
            Sale.make(:appointment => Appointment.make(:lead => @lead, :user => @user))
          }.should change(Lead.sold, :count).by(1)
        end
      end
    end
    
    describe "should find qualified leads where: " do
      before :each do
        @vol = 4
        @emp = 3
        acceptables = SicCode.acceptable
        acceptables.should have(140).items
        @good = acceptables.detect{|sc| sc.vol.to_i == @vol and sc.emp.to_i == @emp }
        @good.should_not be_nil
        @good.vol.should eql(@vol.to_s)
        @good.emp.should eql(@emp.to_s)
        @good.acceptable.should be_true
        @good_sic = @good.sic_code
        @bad_sic = SicCode.all.detect{|sc| not sc.is_acceptable? }.sic_code
      end
      
      it "good sic, > sales, = emps" do
        l = Lead.make(:sic_code_1 => @good_sic, :sales_code => @vol+1, :employee_code => @emp)
        l.sic_code_1.should eql(@good_sic)
        Lead.qualified.should have(1).items
        # Lead.unqualified.should have(0).items
      end 
      
      it "good sic, = sales, = emps" do
        Lead.make(:sic_code_1 => @good_sic, :sales_code => @vol, :employee_code => @emp)
        Lead.qualified.should have(1).items
        # Lead.unqualified.should have(0).items
      end

      it "good sic, < sales, = emps" do
        Lead.make(:sic_code_1 => @good_sic, :sales_code => @vol-1, :employee_code => @emp)
        Lead.qualified.should have(0).items
        # Lead.unqualified.should have(1).items
      end
      
      it "good sic, = sales, > emps" do
        Lead.make(:sic_code_1 => @good_sic, :sales_code => @vol, :employee_code => @emp+1)
        Lead.qualified.should have(1).items
        # Lead.unqualified.should have(0).items
      end
      
      it "good sic, = sales, < emps" do
        Lead.make(:sic_code_1 => @good_sic, :sales_code => @vol, :employee_code => @emp-1)
        Lead.qualified.should have(0).items
        # Lead.unqualified.should have(1).items
      end
      
      it "good sic, < sales, < emps" do
        Lead.make(:sic_code_1 => @good_sic, :sales_code => @vol-1, :employee_code => @emp-1)
        Lead.qualified.should have(0).items
        # Lead.unqualified.should have(1).items
      end

      it "good sic, > sales, > emps" do
        Lead.make(:sic_code_1 => @good_sic, :sales_code => @vol+1, :employee_code => @emp+1)
        Lead.qualified.should have(1).items
        # Lead.unqualified.should have(0).items
      end

      it "bad sic, > sales, = emps" do
        Lead.make(:sic_code_1 => @bad_sic, :sales_code => @vol+1, :employee_code => @emp)
        Lead.qualified.should have(0).items
        # Lead.unqualified.should have(1).items
      end 

      it "bad sic, = sales, = emps" do
        Lead.make(:sic_code_1 => @bad_sic, :sales_code => @vol, :employee_code => @emp)
        Lead.qualified.should have(0).items
        # Lead.unqualified.should have(1).items
      end

      it "bad sic, < sales, = emps" do
        Lead.make(:sic_code_1 => @bad_sic, :sales_code => @vol-1, :employee_code => @emp)
        Lead.qualified.should have(0).items
        # Lead.unqualified.should have(1).items
      end

      it "bad sic, = sales, > emps" do
        Lead.make(:sic_code_1 => @bad_sic, :sales_code => @vol, :employee_code => @emp+1)
        Lead.qualified.should have(0).items
        # Lead.unqualified.should have(1).items
      end

      it "bad sic, = sales, < emps" do
        Lead.make(:sic_code_1 => @bad_sic, :sales_code => @vol, :employee_code => @emp-1)
        Lead.qualified.should have(0).items
        # Lead.unqualified.should have(1).items
      end

      it "bad sic, < sales, < emps" do
        Lead.make(:sic_code_1 => @bad_sic, :sales_code => @vol-1, :employee_code => @emp-1)
        Lead.qualified.should have(0).items
        # Lead.unqualified.should have(1).items
      end

      it "bad sic, > sales, > emps" do
        Lead.make(:sic_code_1 => @bad_sic, :sales_code => @vol+1, :employee_code => @emp+1)
        Lead.qualified.should have(0).items
        # Lead.unqualified.should have(1).items
      end
        
        
      # # GO AWAY??????
      # it "already a client" do
      #   Sale.make(:appointment => Appointment.make(:lead => Lead.make))
      #   
      #   Lead.unsold.should have(@no_change).items
      #   Lead.vacant.should have(@one_more).items
      #   Lead.open.should have(@no_change).items
      # end
      # 
      # it "owned by an active employee plus already a client" do
      #   Lead.make(:users => [User.make(:employee => Employee.make)])
      #   Sale.make(:appointment => Appointment.make(:lead => Lead.make))
      #   
      #   Lead.unsold.should have(@one_more).items
      #   Lead.vacant.should have(@one_more).items
      #   Lead.open.should have(@no_change).items
      # end
    end
    
    describe "by geo" do
      before :each do
        State.all.each do |s|
          Lead.make(:state => s.abbrev)
        end
      end
      
      it "should have one per state" do
        State.all.each do |s|
          Lead.located_in_state_of(s).should have(1).items
          Lead.located_in_state_of(s.abbrev).should have(1).items
        end
      end
      
      it "should have some in each state's timezone" do
        State.all.each do |s|
          # puts s.abbrev
          Lead.located_in_timezone_of(s).should have(s.time_zone.states.count).items
          Lead.located_in_timezone_of(s.abbrev).should have(s.time_zone.states.count).items
        end
      end
      
      it "should have some in each timezone" do
        TimeZone.all.each do |tz|
          Lead.located_in_timezone(tz).should have(tz.states.count).items
          Lead.located_in_timezone(tz.abbrev).should have(tz.states.count).items
        end
      end
    end
  end
  
  describe "avaiable for assignment" do
    #generate each and every scenario:
    # => qualified & unqualified
    # => vacant & held
    # => claimed & unclaimed
    # => valid & invalid
    
    before :each do
      @good_sic = SicCode.acceptable.detect{|sc| sc.vol.to_i == 4 and sc.emp.to_i == 3 }.sic_code
      @bad_sic = SicCode.all.detect{|sc| not sc.is_acceptable? }.sic_code
      @sics = [@good_sic, @bad_sic]
      
      @owners = [nil, User.make(:employee => Employee.make), User.make(:employee => Employee.make(:inactive))]
      
      @provinces = ['TX', 'XX']
      
      @statii = LeadStatus.all + [nil]
    end
    
    # it "should be valid" do
    #   @statii.each do |status|
    #     params = {:sic_code_1 => @good_sic, :state => 'TX'}
    #     params[:status] = status unless status.nil?
    #   
    #     Lead.make(params)
    #   end
    #   Lead.open.should have(Lead.valid.count).items
    # end
    # 
    # it "should be unclaimed" do
    #   Lead.make(:status => nil)
    #   Lead.unclaimed.should have(1).items
    #   Lead.open.should have(1).items
    # end
    # 
    # it "should be vacant" do
    # end
    # 
    # it "should be qualified" do
    #   Lead.make(:sic_code_1 => @good_sic, :sales_code => 4, :employee_code => 3)
    #   Lead.qualified.should have(1).items
    #   Lead.open.should have(1).items
    # end
    
    it "should be vacant, unclaimed, valid and qualified" do
      @sics.each do |sic|
        @owners.each do |user|
          @provinces.each do |state|
            @statii.each do |status|
              params = {
                :sic_code_1 => sic, 
                :state => state,
                :sales_code => 4,
                :employee_code => 3,
              }
              params[:users] = [user] unless user.nil?
              params[:status] = status unless status.nil?
            
              Lead.make(params)
              Contact.make(:lead => Lead.make(params))
            end
          end
        end
      end
      
      Lead.all.should have(@statii.count * @provinces.count * @owners.count * @sics.count * 2).items
      Lead.open.should have(24).items # have(6 * 1 * 2 * 1 * 1).items
    end
  end
  
  describe "lifecycle callbacks" do
    before :each do
      @lead = Lead.make
      @user = User.make(:unsaved)
      @user.leads << @lead
      @user.save
    end
    
    describe "if the lead has a callback" do
      before :each do
        # @callback = CallBack.make(:lead => lead, :user => @user)
        # @callback.status.should eql(CallBackStatus.uncalled)
        @callback = mock_model(CallBack)
        @callback.stub!(:user).and_return(@user)
        @callback.stub!(:[]=).with("lead_id", @lead.id)
        @callback.should_receive(:save).with(any_args()).and_return(true)
        @lead.call_backs = [@callback]
      end
      
      describe "the status of the callback should be set to called" do
        before :each do
          @callback.should_receive(:status).and_return(CallBackStatus.uncalled)
          # @callback.should_receive(:callback_at).and_return(1.hour.ago)
          @callback.should_receive(:status=).with(CallBackStatus.complete)
          @callback.should_receive(:save).with(any_args()).and_return(true)
          
          # @lead.call_backs.should be_present
          # lead_callbacks = @lead.call_backs
          # lead_callbacks.should eql([@callback])
          # lead_callbacks.should have(1).items
          # lead_callback = lead_callbacks.first
          # lead_callback.user.should eql(@lead.owner)
          # lead_callback.callback_at.should < Time.now
          # lead_callback.status.code.should eql(CallBackStatus.uncalled.code)
        end
        
        it "when invoking update_callbacks" do
          @lead.send(:update_callbacks)
        end

        it "when the lead is saved" do
          @lead.sic_code_9 = '12345'
          @lead.save
        end
      end
    end
  end
end
