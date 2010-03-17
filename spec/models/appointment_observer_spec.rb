require 'spec_helper'

describe AppointmentObserver do
  before :each do
    @appt = Appointment.make_unsaved
  end
  
  describe "should try to deliver an email" do
    before :each do
      ProspectMailer.should_receive(:deliver_scheduled_appointment).with(@appt)
    end
    
    it "when after_create is invoked directly" do
      AppointmentObserver.instance.after_save(@appt)
    end
    
    it "when the appointment has a scheduled date" do
      @appt.save
    end
    
    it "when the appt is saved" do
      @appt.scheduled_at = nil
      @appt.save
      @appt.scheduled_at = 1.days.from_now
      @appt.save
    end
  end
  
  it "should not send email if no scheduled date" do
    ProspectMailer.should_not_receive(:deliver_scheduled_appointment).with(@appt)
    @appt.scheduled_at = nil
    @appt.save
  end
end