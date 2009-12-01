
class Lead < ActiveRecord::Base
  include AASM
  
  attr_accessor :next_id
  
  belongs_to :user
  has_many :presentations
  has_many :appointments
  has_many :events
  has_many :comments
  has_and_belongs_to_many :queues
  
  # validations
  validates_email :email
  
  # will_paginate; show up to 100/page
  cattr_reader :per_page
  @@per_page = 100
  
  named_scope :queued, :conditions => { :aasm_state => [ :queued.to_s, :scheduled.to_s ] }
  named_scope :owned_by, lambda{ |u| { :conditions => { :user_id => u } } }
  named_scope :call_list, lambda{ |u| 
    { 
      :conditions => {
        :user_id => u,
        :aasm_state => [ :queued.to_s, :scheduled.to_s ]
      }
    }
  }
  named_scope :preso_callbacks, lambda{ |t|
    {
      :joins => :presentations,
      :conditions => [ 
        'presentations.callback_date <= :cbdate and presentations.callback_time <= :cbtime and leads.aasm_state in (:states)', 
        {
          :cbdate => t.to_datetime, 
          :cbtime => t,
          :states => [:assigned, :queued, :scheduled].map(&:to_s)
        }
      ],
      :order => 'leads.updated_at asc'
    }
  }
  # named_scope :hot, :joins => :presentations
  # named_scope :stale, :joins => :presentations
  # named_scope :open, :joins => :presentations
  # named_scope :hot, lambda{ |as_of|
  #   {
  #     :joins => :presentations, 
  #     # :conditions => {
  #     #   :aasm_state => :scheduled.to_s,
  #     #   [ 'presentations.callback_date < ?', time ] 
  #     # }
  #   }
  # }
  # named_scope :stale, lambda{ |as_of|
  #   {
  #     :joins => :presentations
  #   }
  # }
  # named_scope :open, lambda{ |as_of|
  #   {
  #     :joins => :presentations
  #   }
  # }
  
  def casual_name
    self.name
  end
  
  def full_name
    nickname = (self.salutation == self.first_name) ? '' : "\"#{self.salutation}\" "
    "#{self.first_name} #{nickname}#{self.last_name}"
  end
  
  def honorific
    (self.gender.downcase == 'female' ? 'Ms.' : 'Mr.')
  end
  
  def history
    (self.presentations + self.appointments).map{ |h| h.as_history }.sort{ |fmr,ltr| fmr[:touched_at] <=> ltr[:touched_at] }
  end
  
  def available_states
    possible_events = self.aasm_events_for_current_state.map{ |n| self.class.aasm_events[n] }
    possible_transitions = possible_events.map{ |e| e.transitions_from_state(self.aasm_state.to_sym) }.flatten
    possible_end_states = possible_transitions.map{ |t| t.to }.flatten
    possible_end_states
  end
  
  def status
    self.aasm_state.to_sym
  end
  
  # state machine stuff
  aasm_column :aasm_state
  # aasm_initial_state :free
  aasm_initial_state Proc.new {|l| l.user.nil? ? :free : :assigned }

  aasm_state :free
  aasm_state :assigned
  aasm_state :queued
  aasm_state :scheduled, :enter => :send_invite
  aasm_state :suspended
  aasm_state :orphaned
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

  aasm_event :orphan do
    transitions :to => :orphaned, :from => [:assigned, :queued], :on_transition => :release_lead
  end
  
  aasm_event :schedule do
    transitions :to => :scheduled, :from => [:queued, :assigned]
  end
  
  aasm_event :book do
    transitions :to => :booked, :from => [:scheduled], :guard => :booked_sale?
  end
  
  aasm_event :suspend do
    transitions :to => :suspended, :from => [:free, :assigned, :scheduled, :queued]
  end
  
  aasm_event :release do
    transitions :to => :free, :from => [:assigned, :queued, :scheduled, :suspended, :booked], :on_transition => :release_lead
  end
  
  def send_invite
  end
  
  def send_appointments
  end
  
  def release_lead
    self.user = nil
  end
  
  def booked_sale?
    true
  end
  
  def is_admin?
    true
  end
end
