class Contact < ActiveRecord::Base
  belongs_to :lead
  belongs_to :bc, :foreign_key => 'bcid', :class_name => 'Employee'
  belongs_to :analysis_topic, :foreign_key => 'expert_topic', :class_name => 'AnalysisTopic'
  has_one :appointment, :class_name => 'Schedule'
  alias_attribute :received_at, :rcvd
  
  validates_presence_of :lead
  
  def set_at
  end
  
  def set_at=(date_time)
  end
  
  def recontact_at
  end
  
  def recontact_at=(date_time)
  end
  
  def appt_at
  end
  
  def appt_at=(date_time)
  end
  
  def expert_at
  end
  
  def expert_at=(date_time)
  end
end
