require 'yaml'

class Appointment < ActiveRecord::Base
  belongs_to :scheduler, :class_name => 'User'
  belongs_to :lead
  belongs_to :topic
  
  after_save do |rec| 
    Event.new(
      :lead => rec.lead, 
      :user => rec.scheduler, 
      :qualifier => "#{rec.class.to_s} (#{rec.topic.name})", 
      :action => 'scheduled', 
      :params => { :to => rec.client_email }.to_yaml
    ).save 
  end
  
  validates_email :expert_email, :client_email
  validates_presence_of :expert_email, :client_email, :scheduler, :lead, :location, :duration, :session_date, :session_time
end
