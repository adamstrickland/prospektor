require 'mockingbird/smtp'

class Notifier < ActionMailer::Base
  def booked_sale(lead)
    subject "Sale Pending"
    recipients 'acs-scheduling@trigonsolutions.com'
    from lead.owner.employee.email
    sent_on Time.now
    body({
      :seller => lead.owner.employee.full_name,
      :lead => {
        :client => lead.full_name,
        :company => lead.company,
        :phone => lead.phone
      }
    })
  end
end