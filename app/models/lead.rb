class Lead < ActiveRecord::Base
  include AASM
  aasm_column :state
  
  # AASM stuff
  aasm_initial_state :unassigned

  aasm_state :unassigned
  aasm_state :assigned
  aasm_state :queued
  aasm_state :called
  aasm_state :suspended
  aasm_state :invited
  aasm_state :reconnected
  aasm_state :booked
  # aasm_state :dating,   :enter => :make_happy,        :exit => :make_depressed
  
  aasm_event :assign do
    transitions :to => :assigned, :from => [:unassigned]
  end
  
  aasm_event :enqueue do
    transitions :to => :queued, :from => [:assigned]
  end
  
  aasm_event :disposition do
    transitions :to => :called, :from => [:queued]
    transitions :to => :invited, :from => [:called], :guard => invitation_sent?
  end
  
  aasm_event :reconnect do
    transitions :to => :reconnected, :from => [:invited], :on_transition => complete_sale
  end
  
  aasm_event :book do
    transitions :to => :booked, :from => [:reconnected], :guard => booked_sale?
  end
  
  aasm_event :suspend do
    transition :to => :suspended, :from => [:reconnected, :called]
  end
  
  def complete_sale
  end
  
  def invitation_sent?
  end
  
  def booked_sale?
  end
end
