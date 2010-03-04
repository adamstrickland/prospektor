class AppointmentObserver < ActiveRecord::Observer
  def after_create(appt)
    lead = appt.lead
    # lead.book
    ProspectMailer.deliver_scheduled_appointment(appt)
    lead.save!
  end
end
