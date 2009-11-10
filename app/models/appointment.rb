class Appointment < ActiveRecord::Base
  belongs_to :scheduler, :class_name => 'User'
  belongs_to :lead
  
  validates_email :expert_email, :client_email
  validates_presence_of :expert_email, :client_email, :scheduler, :lead, :location, :duration, :subject, :session_date, :session_time
  
  def as_history
    {
      :type => 'appointment',
      :touched_at => self.created_at,
      :touchpoint => self.client_email
    }
  end
end
