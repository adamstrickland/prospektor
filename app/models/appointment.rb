require 'yaml'

class Appointment < ActiveRecord::Base
  belongs_to :lead
  belongs_to :user
  belongs_to :status, :class_name => 'AppointmentStatus'
  
  validates_presence_of :lead, :user, :status, :duration, :sale_probability
  validates_length_of :no_sale_reason, :maximum => 2000, :allow_nil => true
  validates_numericality_of :duration
  validates_numericality_of :sale_probability, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100
  (1..3).each do |i|
    validates_length_of "problem_#{i}".to_sym, :maximum => 255, :allow_nil => true
    validates_numericality_of "impact_#{i}".to_sym, :allow_nil => true
  end
  
  after_save do |rec|
    # what = "at: #{rec.scheduled_at}, re: #{ rec.topics.join(';') }"
    # what = "#{what[0..252]}..." if what.size > 255
   LeadEvent.set_appointment(rec.lead, rec.scheduled_at, rec.user)
  end
  
  def email
    self.lead.email
  end
  
  def email=(val)
    self.lead.email = val
  end
  
  def topics
    (1..3).map{|i| self.send("problem_#{i}".to_sym) }.compact
  end
end
