class AppointmentObserver < ActiveRecord::Observer
  def after_save(appt)
    if appt.scheduled_at.present?
      lead = appt.lead
      # lead.book
      ProspectMailer.deliver_scheduled_appointment(appt)
      # lead.save
    end
  end
end
