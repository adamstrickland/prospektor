require 'spec_helper'

# belongs_to :lead
# belongs_to :user
# belongs_to :status, :class_name => 'AppointmentStatus'
# 
# validates_presence_of :lead, :user, :status, :duration, :sale_probability, :references_requested
# validates_length_of :no_sale_reason, :max => 2000, :allow_nil => true
# validates_numericality_of :duration
# validates_numericality_of :sale_probability, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100
# (1..3).each do |i|
#   validates_length_of "problem_#{i}".to_sym, :max => 255, :allow_nil => true
#   validates_numericality_of "impact_#{i}".to_sym, :allow_nil => true
# end
# 
# after_save do |rec|
#   what = "at: #{scheduled_at}, re: #{ (1..3).map{|i| self.send("problem_#{i}".to_sym) }.compact.join(';') }"
#   what = "#{what[0..252]}..." if what.size > 255
#   Event.new(
#     :lead => rec.lead,
#     :user => rec.user,
#     :qualifier => what,
#     :action => 'scheduled'
#   ).save
# end

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
    l = Lead.make(:email => 'a@b.com')
    a = Appointment.make(:lead => l)
    a.lead.should_not be_nil
    a.email.should eql(l.email)
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