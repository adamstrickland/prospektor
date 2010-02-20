class Schedule < ActiveRecord::Base
  belongs_to :contact
  belongs_to :employee, :foreign_key => 'user_id', :class_name => 'Employee'
  belongs_to :status, :foreign_key => 'appt_status', :class_name => 'AppointmentStatus'
  has_one :sale
  validates_presence_of :contact, :employee
  
  def callback_at
  end
  
  def callback_at=(date_time)
  end
end
