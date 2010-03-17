class PresentationObserver < ActiveRecord::Observer
  def after_create(preso)
    # lead = preso.lead
    # lead.schedule
    # Rails.logger.warn("User for preso is:  #{preso.user.name}, User for lead is:  #{preso.lead.user.name}")
    ProspectMailer.deliver_presentation_invitation(preso)
    # lead.save!
  end
end
