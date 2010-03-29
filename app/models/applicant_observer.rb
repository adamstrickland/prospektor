class ApplicantObserver < ActiveRecord::Observer
  def after_create(applicant)
    Notifier.deliver_new_applicant_alert(applicant)
  end
end
