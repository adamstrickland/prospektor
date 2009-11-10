class PresentationObserver < ActiveRecord::Observer
  def after_create(preso)
    lead = preso.lead
    lead.book
    ProspectMailer.send_booking(preso.client_email)
    ProspectMailer.send_booking(preso.expert_email)
    lead.save!
  end
end
