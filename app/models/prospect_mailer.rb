require 'mockingbird/smtp'

class ProspectMailer < ActionMailer::Base
  def scheduled_appointment(appt)
    subject "Expert Session Requested"
    recipients appt.email
    # cc appt.expert_email
    cc 'acs@trigonsolutions.com'
    from sender(appt.user.present? ? appt.user.email : 'acs@trigonsolutions.com')
    sent_on Time.now
    body({ 
      :to => {
        :name => appt.lead.full_name,
        :company => appt.lead.company,
        :email => appt.email
      },
      :sender => {
        :name => appt.user.name, 
        :phone => appt.user.official_phone
      },
      :appointment => {
        :date => appt.scheduled_at.strftime('%d %b %Y'),
        :time => appt.scheduled_at.strftime('%I:%M %p'),
        :topic => (appt.topics.present? ? appt.topics.join(', ') : 'Topic of your choice')
      }
    })
  end
  
  def confirmed_appointment(appt)
    subject "Expert Session Reservation Confirmed"
    recipients appt.email
    # cc appt.expert_email
    cc 'acs@trigonsolutions.com'
    # from "#{appt.scheduler.name} <#{appt.scheduler.email}>"
    from sender(appt.user.present? ? appt.user.email : 'acs@trigonsolutions.com')
    sent_on Time.now
    content_type "multipart/mixed"
    parameters = { 
      :to => {
        :name => appt.lead.full_name,
        :company => appt.lead.company,
        :email => appt.email
      },
      :sender => {
        :name => appt.user.name, 
        :phone => appt.user.official_phone
      },
      :appointment => {
        :date => appt.scheduled_at.strftime('%d %b %Y'),
        :time => appt.scheduled_at.strftime('%I:%M %p'),
        :topic => (appt.topics.present? ? appt.topics.join(', ') : 'Topic of your choice')
      }
    }
    part :content_type => 'multipart/alternative' do |mixed|
      mixed.part 'text/plain' do |p|
        p.body = render_message('confirmed_appointment.text.plain', parameters)
        # p.transfer_encoding = 'base64'
      end
      mixed.part 'text/html' do |h|
        h.body = render_message('confirmed_appointment.text.html', parameters)
      end
    end
    # attachment :content_type => 'text/calendar', :body => generate_ics(appt)
  end

  def presentation_invitation(preso)
    subject "#{preso.topic.name} Information"
    recipients preso.email
    from sender(preso.user.email)
    sent_on Time.now
    body ({ 
      :topic => preso.topic.name,
      :to => {
        :name => preso.lead.full_name,
        :company => preso.lead.company,
        :email => preso.email
      }, 
      :url => preso.url, 
      :sender => {
        :name => preso.user.name,
        :phone => preso.user.official_phone
      }
    })
  end

  def bcr_invitation(preso)
    subject "BCR Request"
    recipients preso.email
    from sender(preso.user.email)
    sent_on Time.now
    body ({ 
      :to => {
        :name => preso.lead.full_name,
        :company => preso.lead.company,
        :email => preso.email
      }, 
      :url => "http://www.trigonsolutions.com/videos/BCR200/index.html?key=#{preso.lead.key}", 
      :sender => {
        :name => preso.user.name,
        :phone => preso.user.official_phone
      }
    })
  end
  
  def topics_listing(preso)
    subject "Expert Session Complimentary Topics"
    recipients preso.email
    from sender(preso.user.email)
    sent_on Time.now
    body ({ 
      :to => {
        :name => preso.lead.full_name,
        :company => preso.lead.company,
        :email => preso.email
      }, 
      :sender => {
        :name => preso.user.name,
        :phone => preso.user.official_phone
      },
      :topics => Topic.find_all_by_complimentary(true).map{|t| t.name}
    })
  end
  
  protected
    def generate_ics
    end
    
    def sender(from_email)
      if Rails.configuration.action_mailer.delivery_method == :test || Rails.configuration.action_mailer.smtp_settings[:address] =~ /smtp\.((gmail)|(googlemail))\.com/
        'trigon@mockingbirdsoftware.com'
      else
        from_email
      end
    end
end
