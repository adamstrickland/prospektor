require 'spec_helper'

describe Applicant do
  include ObserverTestHelperMethods
  
  before :all do
    disable_observers
  end
  
  before :each do
    @applicant = Applicant.make
  end
  
  describe "should order open applicants by create date" do
    it "if ordered first" do
      applicant1 = @applicant
      applicant1.should_not be_rejected
      applicant1.employee.should be_nil
      
      applicant2 = Applicant.make
      applicant2.created_at = 1.days.from_now
      applicant2.save!
      applicant2.created_at.should > applicant1.created_at
      applicant2.should_not be_rejected
      applicant2.employee.should be_nil
      
      Applicant.non_employee.should have(2).items
      Applicant.non_rejected.should have(2).items
      
      applicants = Applicant.open
      applicants.should have(2).items
      applicants[0].should eql(applicant1)
      applicants[1].should eql(applicant2)    
    end
    
    it "if unordered first" do
      applicant1 = @applicant
      applicant2 = Applicant.make
      applicant2.created_at = 3.days.ago
      applicant2.save!
      applicant2.created_at.should < applicant1.created_at
      applicants = Applicant.open
      applicants.should have(2).items
      applicants[0].should eql(applicant2)
      applicants[1].should eql(applicant1)
    end
  end
  
  describe "methods" do
  
    it "should create an employee with today as the hire date" do
      @employee = @applicant.create_employee
      [:first_name, :middle_initial, :last_name, :preferred_name, :address, :city, :postal_code, :country, :business_phone].each do |attrib|
        @employee.send(attrib).should eql(@applicant.send(attrib))
      end
      @employee.gender.should eql('M')
      @employee.title.should eql('Sales')
      @employee.department_name.should eql('AS')
      @employee.state_or_province.should eql(@applicant.state_province)
      @employee.phone.should eql(@applicant.home_phone)
      @employee.cellular.should eql(@applicant.mobile_phone)
      @employee.status_change_date.gmtime.should eql(Date.today.to_time.gmtime)
      @employee.date_hired.gmtime.should eql(Date.today.to_time.gmtime)
      @employee.active?.should eql(true)
    end
    
    describe "should only list open applicants" do
      before :each do
        Applicant.open.should have(1).items
      end
      
      after :each do
        Applicant.open.should have(1).items
      end
      
      it "should not include rejected ones" do
        reject = Applicant.make(:rejected => true)
      end
      
      it "should not include employees" do
        employed = Applicant.make(:employee => Employee.make)
      end
    end
  end
  
  describe "validates" do
    describe "phone numbers" do
      before :each do
        @p1 = "8885551212"
        @attrs = [:business_phone, :mobile_phone, :home_phone]
        @attrs.each do |a|
          @applicant.send("#{a}=", nil)
        end
      end
    
      it "should accept all nums for all 3 attrs" do        
        @attrs.each do |a|
          @applicant.send("#{a}=".to_sym, @p1)
        end
        @applicant.should be_valid
      end
      
      it "should accept all nums for biz phone and allow others blank" do
        @applicant.business_phone = @p1
        @applicant.should be_valid
      end
      
      it "should not accept N/A" do
        @applicant.business_phone = 'N/A'
        @applicant.should_not be_valid
      end
      
      describe "should munge to all nums when other common formats are used:" do
        it "(NPA) NXX-YYYY" do
          @applicant.business_phone = "(888) 555-1212"
          @applicant.before_validation_on_create
          @applicant.should be_valid
          @applicant.business_phone.should eql(@p1)
        end
        
        it "NPA-NXX-YYYY" do
          @applicant.business_phone = "888-555-1212"
          @applicant.before_validation_on_create
          @applicant.should be_valid
          @applicant.business_phone.should eql(@p1)
        end
        
        it "NPA.NXX.YYYY" do
          @applicant.business_phone = "888.555.1212"
          @applicant.before_validation_on_create
          @applicant.should be_valid
          @applicant.business_phone.should eql(@p1)
        end
        
        it "NPA/NXX-YYYY" do
          @applicant.business_phone = "888/555-1212"
          @applicant.before_validation_on_create
          @applicant.should be_valid
          @applicant.business_phone.should eql(@p1)
        end
        
        it "should work for all 3 attrs" do
          @attrs.each do |a|
            @applicant.send("#{a}=".to_sym, "888/555-1212")
          end
            @applicant.before_validation_on_create
          @applicant.should be_valid
          @attrs.each do |a|
            @applicant.send(a).should eql(@p1)
          end
        end
      end
    end
  end
end