
class Lead < ActiveRecord::Base
  # include AASM
  include ActionView::Helpers::NumberHelper
  
  # attr_accessor :next_id
  
  # belongs_to :user
  has_and_belongs_to_many :users
  has_many :presentations
  has_many :appointments
  has_many :events
  has_many :comments
  # has_and_belongs_to_many :queues # rm'd w/ impl of Touchpoints
  has_many :touchpoints
  belongs_to :status
  
  # validations
  validates_email :email
  validates_length_of :phone, :is => 10
  validates_uniqueness_of :phone, :message => 'Phone Number can not be changed (already assigned).  Disposition Lead to DUP, with desired phone number in comments field.'
  
  
  # will_paginate; show up to 100/page
  cattr_reader :per_page
  @@per_page = 100
  
  # named_scope :queued, :conditions => { :aasm_state => [ :queued.to_s, :scheduled.to_s ] }
  # named_scope :available, 
  named_scope :callbacks, lambda{ |t|
    {
      :joins => :presentations,
      :conditions => [ 
        'presentations.callback_date <= :cbdate and presentations.callback_time <= :cbtime and leads.aasm_state in (:states)', 
        {
          :cbdate => t.to_datetime, 
          :cbtime => t,
          # :states => [:assigned, :queued, :scheduled].map(&:to_s)
          :states => [:scheduled].map(&:to_s)
        }
      ],
      :order => 'leads.updated_at asc'
    }
  }
  # named_scope :open, :conditions => { :aasm_state => [:assigned, :queued].map(&:to_s) }, :order => ['leads.updated_at', :zip, :city, :county, :state].join(',')
  # named_scope :open, :conditions => { :status_id => ['NULL'] }, :order => ['leads.updated_at', :zip, :city, :county, :state].join(',')
  
  after_save do |rec|
  end
  
  after_validation_on_update do |rec|
    rec.changes.each do |attr, vals|
      vals[0] = 'NULL' if vals[0].blank?
      Event.new(
        :lead => rec, 
        :user => rec.owner, 
        :qualifier => "Attribute #{attr.camelize} from #{vals[0]} to #{vals[1]}", 
        :action => 'updated'
      ).save
    end
  end
  
  def casual_name
    self.name
  end
  
  # def full_name
  #   nickname = (self.salutation == self.first_name) ? '' : "\"#{self.salutation}\" "
  #   "#{self.first_name} #{nickname}#{self.last_name}"
  # end
  
  def formatted_phone=(val)
    self.phone = val.gsub(/[-\.\s\(\)]/, "")
  end
  
  def formatted_phone
    number_to_phone(self.phone)
  end
  
  def honorific
    (['f', 'female'].include?(self.gender.downcase) ? 'Ms.' : 'Mr.')
  end
  
  def honorific=(val)
    case val.upcase
    when /MS\.?/, /MRS\.?/ then self.gender = 'F'
    when /MR\.?/ then self.gender = 'M'
    end
  end
  
  def history
    (self.presentations + self.appointments).map{ |h| h.as_history }.sort{ |fmr,ltr| fmr[:touched_at] <=> ltr[:touched_at] }
  end

  def owner
    self.users.last
  end
  
  def credit_rating
    case self.credit_score
    when nil? then 'Unknown'
    when (90..100) then 'Excellent'
    when (80..89) then 'Very Good'
    when (70..79) then 'Good'
    when (60..69) then 'OK'
    else 'Poor'
    end
  end
  
  # def available_states
  #   possible_events = self.aasm_events_for_current_state.map{ |n| self.class.aasm_events[n] }
  #   possible_transitions = possible_events.map{ |e| e.transitions_from_state(self.aasm_state.to_sym) }.flatten
  #   possible_end_states = possible_transitions.map{ |t| t.to }.flatten
  #   possible_end_states
  # end
  
  # def status
  #   self.aasm_state.to_sym
  # end
  
  def employee_category
    cat = case (self.employee_code || 0).to_i
      when 0 then 'N/A'
      when 1 then '1 - 4'
      when 2 then '5 - 9'
      when 3 then '10 - 19'
      when 4 then '20 - 49'
      when 5 then '50 - 99'
      when 6 then '100 - 249'
      when 7 then '250 - 499'
      when 8 then '500 - 999'
      when 9 then '1,000+'
    end
    "#{cat} employees"
  end
  
  def sales_category
    case (self.sales_code || 0).to_i
    when 0 then 'N/A'
    when 1 then '$0 - $499K'
    when 2 then '$500K - $999K'
    when 3 then '$1M - $2.49M'
    when 4 then '$2.5M - $4.9M'
    when 5 then '$5M - $9.9M'
    when 6 then '$10M - $19M'
    when 7 then '$20M - $49M'
    when 8 then '$50M - $99M'
    when 9 then '$100M - $249M'
    when 10 then '$250M - $499M'
    when 11 then '$500M - $999M'
    when 12 then '$1B+'
    end
  end
  
  # # state machine stuff
  # aasm_column :aasm_state
  # # aasm_initial_state :free
  # aasm_initial_state Proc.new {|l| l.user.nil? ? :free : :assigned }
  # 
  # aasm_state :free
  # aasm_state :assigned
  # aasm_state :queued
  # aasm_state :scheduled, :enter => :send_invite
  # aasm_state :suspended
  # aasm_state :orphaned
  # aasm_state :booked, :enter => :send_appointments
  # 
  # aasm_event :assign do
  #   transitions :to => :assigned, :from => [:free, :suspended], :guard => :is_admin?
  # end
  # 
  # aasm_event :reassign do
  #   transitions :to => :assigned, :from => [:assigned, :queued]
  #   transitions :to => :scheduled, :from => [:scheduled]
  #   transitions :to => :booked, :from => [:booked]
  # end
  # 
  # aasm_event :enqueue do
  #   transitions :to => :queued, :from => [:assigned]
  # end
  # 
  # aasm_event :requeue do
  #   transitions :to => :queued, :from => [:queued]
  # end
  # 
  # aasm_event :unqueue do
  #   transitions :to => :assigned, :from => [:queued, :scheduled]
  # end
  # 
  # aasm_event :orphan do
  #   transitions :to => :orphaned, :from => [:assigned, :queued], :on_transition => :release_lead
  # end
  # 
  # aasm_event :schedule do
  #   transitions :to => :scheduled, :from => [:queued, :assigned]
  # end
  # 
  # aasm_event :book do
  #   transitions :to => :booked, :from => [:scheduled], :guard => :booked_sale?
  # end
  # 
  # aasm_event :suspend do
  #   transitions :to => :suspended, :from => [:free, :assigned, :scheduled, :queued]
  # end
  # 
  # aasm_event :release do
  #   transitions :to => :free, :from => [:assigned, :queued, :scheduled, :suspended, :booked], :on_transition => :release_lead
  # end
  # 
  # def send_invite
  # end
  # 
  # def send_appointments
  # end
  # 
  # def release_lead
  #   self.user = nil
  # end
  # 
  # def booked_sale?
  #   true
  # end
  # 
  # def is_admin?
  #   true
  # end
end
