require 'digest/sha1'
require 'base64'

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
  has_many :response_sets
  belongs_to :status, :class_name => 'LeadStatus'
  
  # validations
  validates_email :email
  validates_length_of :phone, :is => 10
  validates_uniqueness_of :phone, :message => 'Phone Number can not be changed (already assigned).  Disposition Lead to DUP, with desired phone number in comments field.'
  
  
  # will_paginate; show up to 100/page
  cattr_reader :per_page
  @@per_page = 100
  
  # named_scope :queued, :conditions => { :aasm_state => [ :queued.to_s, :scheduled.to_s ] }
  # named_scope :available, 
  # named_scope :open, :conditions => { :aasm_state => [:assigned, :queued].map(&:to_s) }, :order => ['leads.updated_at', :zip, :city, :county, :state].join(',')
  # named_scope :open, :conditions => { :status_id => ['NULL'] }, :order => ['leads.updated_at', :zip, :city, :county, :state].join(',')
  # named_scope :open,
  
  named_scope :callbacks, 
    lambda { |t|
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
        :order => 'leads.updated_at desc'
      }
    },
    :negative => false
    
  named_scope :located_in_state_of, 
    lambda { |st|
      {
        :conditions => { :state => st.respond_to?(:state_name) ? st.state : st }
      }
    },
    :negative => false
  def self.located_in_timezone_of(st)
    self.located_in_timezone(st.respond_to?(:state_name) ? st.time_zone.abbrev : State.find_by_state(st).time_zone.abbrev)
  end
  named_scope :located_in_timezone,
    lambda{ |tz|
      {
        :joins => 'INNER JOIN states ON (leads.state = states.state) INNER JOIN time_zones ON (states.time_zone_id = time_zones.id)',
        :conditions => [
          'time_zones.time_zone = :tz', { :tz => tz.respond_to?(:abbrev) ? tz.abbrev : tz }
        ]
      }
    },
    :negative => false
    
  named_scope :valid, 
    :joins => 'LEFT OUTER JOIN statuses ON (leads.status_id = statuses.id)', 
    :conditions => "leads.state != 'XX' AND (
      leads.status_id IS NULL OR 
      statuses.state NOT IN ('dead', 'suspend', 'transfer')
    )",
    :negative => :invalid
  named_scope :dead, 
    :joins => :status,
    :conditions => ['statuses.state = ?', 'dead'], 
    :negative => false
  named_scope :unclaimed, 
    :joins => 'LEFT OUTER JOIN statuses ON (leads.status_id = statuses.id)',
    :conditions => "leads.status_id IS NULL OR (statuses.state <> 'transfer' AND NOT EXISTS (
      SELECT 1
      FROM contacts C LEFT OUTER JOIN
        schedules K ON (C.id = K.contact_id) LEFT OUTER JOIN
        sales S ON (K.id = S.appointment_id)
      WHERE
        C.lead_id = leads.id
    ))", 
    :negative => :claimed
  named_scope :unsuspended, 
    :joins => 'LEFT OUTER JOIN statuses ON (leads.status_id = statuses.id)',
    :conditions => "leads.status_id IS NULL OR statuses.state <> 'suspend'",
    :negative => :suspended
    
  named_scope :client, 
    :conditions => 'EXISTS (
      SELECT 1
      FROM contacts C INNER JOIN
        schedules K ON (C.id = K.contact_id) LEFT OUTER JOIN
        sales S ON (K.id = S.appointment_id)
      WHERE
        C.lead_id = leads.id
    )'
  named_scope :held,
    :conditions => "EXISTS (
      SELECT 1
      FROM leads L INNER JOIN
        leads_users LU ON (L.id = LU.lead_id) INNER JOIN
        users U ON (LU.user_id = U.id) INNER JOIN
        employees E ON (U.employee_id = E.id)
      WHERE E.active IN (1, 'y', 't', 'Y', 'T')
      AND L.id = leads.id
    )", 
    :negative => :vacant
  named_scope :sold, 
    :conditions => "EXISTS (
      SELECT 1 
      FROM sales S INNER JOIN 
      	schedules SH ON (S.appointment_id = SH.id) INNER JOIN
      	contacts C ON (SH.contact_id = C.id)
      WHERE C.lead_id = leads.id
    )", 
    :negative => :unsold
  named_scope :qualified,
    :joins => 'INNER JOIN sic_codes ON (leads.sic_code_1 = sic_codes.sic_code)',
    :conditions => 'leads.employee_code >= sic_codes.emp AND 
      leads.sales_code >= sic_codes.vol
    ',
    :negative => :unqualified
    
  named_scope :open,
    :joins => 'INNER JOIN 
      sic_codes ON (leads.sic_code_1 = sic_codes.sic_code) LEFT OUTER JOIN
      statuses ON (leads.status_id = statuses.id)
    ',
    :conditions => "leads.employee_code >= sic_codes.emp AND 
      leads.sales_code >= sic_codes.vol AND 
      NOT EXISTS (
        SELECT 1
        FROM leads L INNER JOIN
          leads_users LU ON (L.id = LU.lead_id) INNER JOIN
          users U ON (LU.user_id = U.id) INNER JOIN
          employees E ON (U.employee_id = E.id)
        WHERE E.active IN (1, 'y', 't', 'Y', 'T')
        AND L.id = leads.id
      ) AND 
      (
        leads.status_id IS NULL OR (
          statuses.state NOT IN ('dead', 'suspend', 'transfer') AND 
          NOT EXISTS (
            SELECT 1
            FROM contacts C LEFT OUTER JOIN
              schedules K ON (C.id = K.contact_id) LEFT OUTER JOIN
              sales S ON (K.id = S.appointment_id)
            WHERE
              C.lead_id = leads.id
          )
        )
      )
    "
  
  # def self.open
  #   self.valid.unclaimed.vacant.qualified
  # end
  
  after_save do |rec|
  end
  
  after_validation_on_update do |rec|
    rec.changes.each do |attrib, vals|
      puts "ATTR: #{attrib}, VALS: #{vals}"
      if ['status_id', :status_id].include?(attrib)
        old_status, new_status = vals.map{ |v| v.blank? ? 'Empty' : Status.find(v).code }
        Event.new(
          :lead => rec, 
          :user => rec.owner, 
          :qualifier => "Changed Status from #{old_status} to #{new_status}", 
          :action => 'updated'
        ).save
      else
        old_val, new_val = vals[0] || 'Empty', vals[1] || vals[0]
        Event.new(
          :lead => rec, 
          :user => rec.owner, 
          :qualifier => "Attribute #{attrib.camelize} from #{old_val} to #{new_val}", 
          :action => 'updated'
        ).save
      end
    end
  end
  
  def casual_name
    self.name
  end
  
  def full_name
    # nickname = (self.salutation == self.first_name) ? '' : "\"#{self.salutation}\" "
    # "#{self.first_name} #{nickname}#{self.last_name}"
    
    [self.first_name, (self.salutation.present? && self.salutation != self.first_name) ? "\"#{self.salutation}\"" : nil, self.last_name].compact.join(" ")
  end
  alias_method :prospect, :full_name
  
  def key
    Base64.encode64(self.phone).strip
  end
  
  def self.find_by_key(key)
    key && key.present? ? self.find_by_phone(Base64.decode64(key.strip)) : nil
  end
  
  # def self.find_by_key(key)
  #   self.find_by_phone()
  # end
  
  def formatted_phone=(val)
    self.phone = val.gsub(/[-\.\s\(\)]/, "")
  end
  
  def formatted_phone
    number_to_phone(self.phone)
  end
  
  def honorific
    if self.gender
      (['f', 'female'].include?(self.gender.downcase) ? 'Ms.' : 'Mr.')
    else
      ''
    end
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
  
  def dummy_reference_number
    "TL#{self.key.unpack('ccc').join}"
  end
  
  def is_manufacturer?
    (1..10).map{|i| "sic_code_#{i}".to_sym }.map{|m| self.send(m) }.compact.map{|c| SicCode.find_by_code(c).division }.include?('D')
  end
end
