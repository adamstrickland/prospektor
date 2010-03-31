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
  
  # def confirmed_appointment(appt)
  #   subject "Expert Session Reservation Confirmed"
  #   recipients appt.email
  #   cc 'acs@trigonsolutions.com'
  #   from system_sender
  #   sent_on Time.now
  #   content_type "multipart/mixed"
  #   parameters = { 
  #     :to => {
  #       :name => appt.lead.full_name,
  #       :company => appt.lead.company,
  #       :email => appt.email
  #     },
  #     :sender => {
  #       :name => appt.user.name, 
  #       :phone => appt.user.official_phone
  #     },
  #     :appointment => {
  #       :date => appt.scheduled_at.strftime('%d %b %Y'),
  #       :time => appt.scheduled_at.strftime('%I:%M %p'),
  #       :topic => (appt.topics.present? ? appt.topics.join(', ') : 'Topic of your choice')
  #     }
  #   }
  #   part :content_type => 'multipart/alternative' do |mixed|
  #     mixed.part 'text/plain' do |p|
  #       p.body = render_message('confirmed_appointment.text.plain', parameters)
  #     end
  #     mixed.part 'text/html' do |h|
  #       h.body = render_message('confirmed_appointment.text.html', parameters)
  #     end
  #   end
  # end

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

  # def bcr_invitation(preso)
  #   subject "BCR Request"
  #   recipients preso.email
  #   from system_sender
  #   sent_on Time.now
  #   body ({ 
  #     :to => {
  #       :name => preso.lead.full_name,
  #       :company => preso.lead.company,
  #       :email => preso.email
  #     }, 
  #     :url => "http://www.trigonsolutions.com/videos/BCR200/index.html?key=#{preso.lead.key}", 
  #     :sender => {
  #       :name => preso.user.name,
  #       :phone => preso.user.official_phone
  #     }
  #   })
  # end
  
  # def topics_listing(preso)
  #     subject "Expert Session Complimentary Topics"
  #     recipients preso.email
  #     from system_sender
  #     sent_on Time.now
  #     body ({ 
  #       :to => {
  #         :name => preso.lead.full_name,
  #         :company => preso.lead.company,
  #         :email => preso.email
  #       }, 
  #       :sender => {
  #         :name => preso.user.name,
  #         :phone => preso.user.official_phone
  #       },
  #       :topics => Topic.find_all_by_complimentary(true).map{|t| t.name}
  #     })
  #   end
  
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
