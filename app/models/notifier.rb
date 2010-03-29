require 'mockingbird/smtp'

class Notifier < ActionMailer::Base
  def booked_sale(lead)
    subject "Sale Pending"
    recipients 'acs-scheduling@trigonsolutions.com'
    # from lead.owner.employee.email
    from "Prospektor <system@trigonsolutions.com>"
    sent_on Time.now
    body({
      :seller => lead.owner.employee.blank? ? lead.owner.login : lead.owner.employee.full_name,
      :lead => {
        :full_name => lead.full_name,
        :company => lead.company,
        :phone => lead.phone
      }
    })
  end
  
  def snoop_alert(user, request={})
    subject "Snoop Alert!"
    recipients 'prospektor-admin@trigonsolutions.com'
    from "Prospektor"
    sent_on Time.now
    body({
      :snoop => user,
      :context => request
    })
  end
  
  def new_applicant_alert(applicant)
    subject "New Applicant"
    recipients 'hr@trigonsolutions.com'
    from "Prospektor"
    sent_on Time.now
    body({ :applicant => applicant })
  end
end