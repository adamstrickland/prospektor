require 'mockingbird/smtp'

class ProspectMailer < ActionMailer::Base
  def scheduled_appointment(appt)
    send_using({
      :subject => "Expert Session Requested",
      :to => appt.email,
      :headers => { 'Reply-to' => appt.user.email },
      :body =>{
        :to => {
          :name => appt.lead.full_name,
          :company => appt.lead.company,
          :email => appt.email
        },
        :sender => {
          :name => appt.user.employee.full_name, 
          :phone => appt.user.official_phone
        },
        :appointment => {
          :date => appt.scheduled_at.strftime('%d %b %Y'),
          :time => appt.scheduled_at.strftime('%I:%M %p'),
          :topic => (appt.topics.present? ? appt.topics.join(', ') : 'Topic of your choice')
        }
      }
    })
  end

  def presentation_invitation(preso)
    send_using(
      :subject => "#{preso.topic.name} Information", 
      :to => preso.email, 
      :headers => {'Reply-to' => preso.user.email},
      :body => {
        :topic => preso.topic.name,
        :to => {
          :name => preso.lead.full_name,
          :company => preso.lead.company,
          :email => preso.email
        }, 
        :url => preso.url, 
        :sender => {
          :name => preso.user.employee.full_name,
          :phone => preso.user.official_phone
        }
      }
    )
  end
  
  protected
    def send_using(options={})
      options[:from] ||= system_sender
      options[:at] ||= Time.now
      options[:body] ||= {}
      
      subject options[:subject]
      recipients options[:to]
      from options[:from]
      sent_on options[:at]
      headers options[:headers] if options[:headers]
      body options[:body]
    end
    
    def system_email
      "system@trigonsolutions.com"
    end
    
    def system_sender
      named_sender('Trigon Solutions')
    end
    
    def named_sender(name)
      "'#{name}' <#{system_email}>"  
    end
    
    def user_sender(user)
      named_sender(user.employee.full_name)
    end
end
