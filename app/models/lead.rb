class Lead < ActiveRecord::Base
  include AASM
  
  has_and_belongs_to_many :users
  
  
  # state machine stuff
  aasm_column :aasm_state
  aasm_initial_state :free

  aasm_state :free
  aasm_state :assigned
  aasm_state :queued
  aasm_state :scheduled, :enter => :send_invite
  aasm_state :suspended
  aasm_state :booked, :enter => :send_appointments
  
  aasm_event :assign do
    transitions :to => :assigned, :from => [:free, :suspended], :guard => :is_admin?
  end
  
  aasm_event :reassign do
    transitions :to => :assigned, :from => [:assigned, :queued]
    transitions :to => :scheduled, :from => [:scheduled]
    transitions :to => :booked, :from => [:booked]
  end
  
  aasm_event :enqueue do
    transitions :to => :queued, :from => [:assigned]
  end
  
  aasm_event :requeue do
    transitions :to => :queued, :from => [:queued]
  end
  
  aasm_event :unqueue do
    transitions :to => :assigned, :from => [:queued, :scheduled]
  end
  
  aasm_event :schedule do
    transitions :to => :scheduled, :from => [:queued, :assigned]
  end
  
  aasm_event :book do
    transitions :to => :booked, :from => [:scheduled], :guard => :booked_sale?
  end
  
  aasm_event :suspend do
    transitions :to => :suspended, :from => [:scheduled, :queued]
  end
  
  def send_invite
  end
  
  def send_appointments
  end
  
  def booked_sale?
    true
  end
  
  def is_admin?
    true
  end
end
