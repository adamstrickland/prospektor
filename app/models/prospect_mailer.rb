class ProspectMailer < ActionMailer::Base
  def send_booking(appt)
    subject "Subject Matter Expert Meeting:  #{appt.subject.titleize}"
    recipients appt.client_email
    from "#{appt.user.name} <#{appt.user.email}>"
    sent_on Time.now
    content_type "multipart/alternative"
    parameters = { 
      :to => appt.lead.name, 
      :from => appt.user.name, 
      :regarding => appt.subject, 
      :appointment => {
        :date => appt.session_date,
        :time => appt.session_time,
        :location => appt.location
      },
      :expert => {
        :name => 'Luis Luarca',
        :gender => :male,
        :credentials => 'Lots of stuff',
        :phone => '800-555-1212',
        :email => appt.expert_email
      }
    }
    
    part :content_type => 'text/html', :body => render_message('send_booking.text.html', parameters)
    part 'text/plain' do |p|
      p.body = render_message('send_booking.text.plain', parameters)
      p.transfer_encoding = 'base64'
    end
    # attachment :content_type => 'text/calendar', :body => generate_ics(appt)
  end

  def schedule_presentation(preso)
    subject "Answering Today's Challenges"
    recipients preso.email
    from "#{preso.user.name} <#{preso.user.email}>"
    sent_on Time.now
    body { :to => preso.lead.name, :url => preso.url, :from => preso.user.name }
  end
  
  
  protected
    def setup_email(email)
      @recipients  = "#{email}"
      @from        = "ADMINEMAIL"
      @subject     = "[YOURSITE] "
      @sent_on     = Time.now
      @body[:user] = user
    end
    
    def generate_ics
    end
end
