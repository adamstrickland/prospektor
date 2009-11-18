require 'yaml'

class Appointment < ActiveRecord::Base
  belongs_to :scheduler, :class_name => 'User'
  belongs_to :lead
  belongs_to :topic
  
  validates_email :expert_email, :client_email
  validates_presence_of :expert_email, :client_email, :scheduler, :lead, :location, :duration, :session_date, :session_time
  
  # def as_history
  #   {
  #     :type => 'appointment',
  #     :touched_at => self.created_at,
  #     :touchpoint => self.client_email
  #   }
  # end
  def generate_event
    e = Event.new
    e.lead = self.lead
    e.user = self.scheduler
    e.qualifier = "#{self.class.to_s} (#{self.topic.name})"
    e.action = 'scheduled'
    e.params = { :to => self.client_email }.to_yaml
    e
  end
end
