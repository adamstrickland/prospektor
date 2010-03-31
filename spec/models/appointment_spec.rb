require 'spec_helper'

describe Appointment do
  
  describe "checking validity" do
    before :each do
      @params = {
        :lead => Lead.make,
        :user => User.make,
        :status => AppointmentStatus.find_by_code('CB'),
        :duration => 1,
        :sale_probability => 50,
        :references_requested => true,
        :no_sale_reason => 'Just because',
        :problem_1 => 'Human Resources',
        # :impact_1 => 10000,
      }
    end
  
    it "should not pass when just defaults" do
      Appointment.new.should_not be_valid
    end
    
    it "should be valid with all params" do
      Appointment.new(@params).should be_valid
    end
    
    it "should create an event on successful save" do
      lambda{
        Appointment.new(@params).save!
      }.should change(LeadEvent, :count).by(1)
    end
    
    it "should require a lead" do
      Appointment.new(@params.merge({:lead => nil})).should_not be_valid
    end
    
    it "should require a user" do
      Appointment.new(@params.merge({:user => nil})).should_not be_valid
    end
    
    it "should require a status" do
      Appointment.new(@params.merge({:status => nil})).should_not be_valid
    end
    
    it "should restrict the length of a no sale text" do
      text = Faker::Lorem.paragraphs(100).join(' ')[0..2000]
      text.size.should eql(2001)
      Appointment.new(@params.merge({:no_sale_reason => text})).should_not be_valid
      Appointment.new(@params.merge({:no_sale_reason => text[0..1999]})).should be_valid
      Appointment.new(@params.merge({:no_sale_reason => nil})).should be_valid
    end
    
    it "should require duration to be a number" do
      Appointment.new(@params.merge({:duration => 'A'})).should_not be_valid
    end
    
    it "should require sale probability to be a number b/t 0 & 100 (percentage)" do
      Appointment.new(@params.merge({:sale_probability => 'A'})).should_not be_valid
      Appointment.new(@params.merge({:sale_probability => -1})).should_not be_valid
      Appointment.new(@params.merge({:sale_probability => 101})).should_not be_valid
    end
    
    it "should check the length of problems but allow them to be empty" do
      text = Faker::Lorem.words(255).join
      Appointment.new(@params.merge({:problem_1 => nil})).should be_valid
      Appointment.new(@params.merge({:problem_1 => text})).should_not be_valid
      Appointment.new(@params.merge({:problem_1 => text[0..254]})).should be_valid
    end
    
    it "should require the impact vals to be numeric" do
      Appointment.new(@params.merge({:impact_1 => nil})).should be_valid
      Appointment.new(@params.merge({:impact_1 => 10000000000000})).should be_valid
      Appointment.new(@params.merge({:impact_1 => 'A'})).should_not be_valid
    end
      
  end
  
  it "should use the lead's email address" do
    @user = mock_user
    @user.stub(:official_phone).and_return(Faker::PhoneNumber.phone_number)
    # users = [@user]
    # l = Lead.make(:email => 'a@b.com', :owner => @user)
    lead = stub_model(Lead)
    email = Faker::Internet.email
    lead.stub(:email).and_return(email)
    a = Appointment.new(:lead => lead, :user => @user)
    # a.lead.should_not be_nil
    a.email.should eql(email)
  end
  
  it "should change the leads email addy if changed for the appt" do
    # l = Lead.make(:readonly => false)
    lead = mock_model(Lead)
    old_email = 'ook@unseenuniversity.edu'
    new_email = 'a@b.com'
    
    lead.stub!(:id).and_return(99999)
    lead.should_receive(:email=).with(new_email)
    lead.stub!(:destroyed?).and_return(false)
    lead.should_receive(:email).any_number_of_times
    lead.should_receive(:full_name).any_number_of_times.and_return('Bill Gates')
    lead.should_receive(:company).any_number_of_times.and_return('Microsoft')
    lead.should_receive(:save!).any_number_of_times.and_return(true)
    
    a = Appointment.new(:lead => lead)
    a.email = new_email
  end
end