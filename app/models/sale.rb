class Sale < ActiveRecord::Base
  belongs_to :appointment, :class_name => 'Schedule'
  belongs_to :rep, :class_name => 'Employee'
  belongs_to :partner, :foreign_key => 'par_id', :class_name => 'Employee'
  alias_attribute :booked_at, :booked
  alias_attribute :client_reference_number, :client_referenc_number
  validates_presence_of :appointment, :client_reference_number
  
  def scheduled_at
  end
  
  def scheduled_at=(date_time)
  end
end
