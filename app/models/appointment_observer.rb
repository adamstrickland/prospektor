class AppointmentObserver < ActiveRecord::Observer
  def after_create(appt)
    lead = appt.lead
    lead.schedule
    ProspectMailer.schedule_presentation(appt.email)
    lead.save!
  end
end
