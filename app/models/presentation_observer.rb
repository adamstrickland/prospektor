class PresentationObserver < ActiveRecord::Observer
  def after_create(preso)
    ProspectMailer.deliver_presentation_invitation(preso)
  end
end
