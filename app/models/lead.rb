require 'digest/sha1'
require 'base64'
require 'chronic'

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
  has_many :response_sets
  belongs_to :status, :class_name => 'LeadStatus'
  has_many :call_backs
  alias_attribute :callbacks, :call_backs
  
  # validations
  validates_email :email
  validates_length_of :phone, :is => 10
  validates_uniqueness_of :phone, :message => 'Phone Number can not be changed (already assigned).  Disposition Lead to DUP, with desired phone number in comments field.'
  

  after_validation_on_update :log_event
  # after_save :update_callbacks
  
  # will_paginate; show up to 100/page
  cattr_reader :per_page
  @@per_page = 100
  
  named_scope :searchy,
    lambda{ |term|
      search_columns = [:first_name, :last_name, :salutation, :title, :company, :address, :city, :state, :county, :zip, :phone]
      {
        :conditions => Lead.conditions_by_like(term, search_columns)
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
        # :include => [:status, :time_zone],
        :select => 'leads.*',
        :joins => 'INNER JOIN states ON (leads.state = states.state) INNER JOIN time_zones ON (states.time_zone_id = time_zones.id)',
        :conditions => [
          'time_zones.time_zone = :tz', { :tz => tz.respond_to?(:abbrev) ? tz.abbrev : tz }
        ]
      }
    },
    :negative => false
    
  # TODO: Revamp all these queries to use :appointments table
  named_scope :untouched,
    :conditions => 'leads.status_id IS NULL',
    :order => 'leads.updated_at ASC',
    :negative => false
  named_scope :touched,
    :include => :status,
    :conditions => "leads.status_id IS NOT NULL AND statuses.state = 'assigned'",
    :order => 'leads.updated_at ASC'
  named_scope :valid, 
    :select => 'leads.*',
    :include => [:status],
    #:joins => 'LEFT OUTER JOIN statuses ON (leads.status_id = statuses.id)', 
    :conditions => "leads.state != 'XX' AND (
      leads.status_id IS NULL OR 
      statuses.state NOT IN ('dead', 'suspend', 'transfer')
    )",
    :negative => :invalid
  named_scope :dead, 
    :include => [:status],
    #:joins => :status,
    :conditions => ['statuses.state = ?', 'dead'], 
    :negative => false
  named_scope :unclaimed,   
    :include => [:status],
    # :joins => 'LEFT OUTER JOIN statuses ON (leads.status_id = statuses.id)',
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
    :include => [:status],
    #:joins => 'LEFT OUTER JOIN statuses ON (leads.status_id = statuses.id)',
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
      	appointments A ON (S.appointment_id = A.id)
      WHERE A.lead_id = leads.id
    )", 
    :negative => :unsold
  named_scope :qualified,
    # :include => [:sic_code],
    :select => 'leads.*',
    :joins => 'INNER JOIN sic_codes ON (leads.sic_code_1 = sic_codes.sic_code)',
    :conditions => 'leads.employee_code >= sic_codes.emp AND 
      leads.sales_code >= sic_codes.vol
    ',
    :negative => :unqualified
    
  named_scope :open,  
    :select => 'leads.*',
    :include => [:status],
    :joins => 'INNER JOIN sic_codes ON (leads.sic_code_1 = sic_codes.sic_code)',
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
    ",
    :negative => false
  
  def casual_name
    self.name
  end
  
  def full_name    
    [self.first_name, (self.salutation.present? && self.salutation != self.first_name) ? "\"#{self.salutation}\"" : nil, self.last_name].compact.join(" ") || self.name
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

  def owner=(ownr)
    self.users << ownr
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
      when 1 then '1 - 4'
      when 2 then '5 - 9'
      when 3 then '10 - 19'
      when 4 then '20 - 49'
      when 5 then '50 - 99'
      when 6 then '100 - 249'
      when 7 then '250 - 499'
      when 8 then '500 - 999'
      when 9 then '1,000+'
      else 'N/A'
    end
    "#{cat} employees"
  end
  
  def sales_category
    case (self.sales_code || 0).to_i
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
    else 'N/A'
    end
  end
  
  def dummy_reference_number
    "TL#{self.key.unpack('ccc').join}"
  end
  
  def is_manufacturer?
    (1..10).map{|i| "sic_code_#{i}".to_sym }.map{|m| self.send(m) }.compact.map{|c| 
      sic = SicCode.find_by_code(c)
      sic.present? ? sic.division : nil
    }.include?('D')
  end
  alias_method :manufacturer?, :is_manufacturer?
  
  def primary_sic
    SicCode.find_by_code(self.sic_code_1)
  end
  
  def primary_sic_division
    self.primary_sic.present? ? self.primary_sic.division : "Unknown"
  end
  
  def business_type
    self.primary_sic.present? ? self.primary_sic.division_name : "Unknown"
  end
  
  def gmt_offset
    ([:e, :c, :m, :p, :a, :h].index(self.timezone.downcase.to_sym) + 4 + (Time.now.zone.index('ST') ? 1 : 0 )) * -1
  end
  
  def disposition!(user, options)
    # if self.complete_callbacks!(options[:user] || self.owner)
    # if user.complete_callbacks!
    if self.staleify_callbacks!
      if options[:disposition] == 'BS'
        self.book_sale!(user, options)
      else
        if ['CB','RS','VM','FP'].include?(options[:disposition])
          self.set_callback!(user, options)
        else
          self.update_status!(options[:disposition])
        end
      end
    else
      false
    end
  end
  
  def staleify_callbacks!
    stale = CallBackStatus.stale
    self.callbacks.all.each{ |cb| cb.status = stale; cb.save }
  end
  
  def book_sale!(user, options)
    comment!(options[:comments], user) if options[:comments]
    result = self.update_status!('CB')
    Notifier.deliver_booked_sale(self)
    result
  end
  
  def set_callback!(user, options)
    comment!(options[:comments], user) if options[:comments]
    self.callbacks << CallBack.new(
      :user => user, 
      :callback_at => options[:callback_at] || Chronic.parse('tomorrow at 9am'), 
      :status => CallBackStatus.find_by_code('UN')
    )
    self.update_status!(options[:disposition])
  end
  
  def update_status!(code)
    status = (code.respond_to?(:code) ? code : LeadStatus.find_by_code(code))
    self.status = status
    self.save
  end
  
  # def complete_callbacks!
  #   self.callbacks.each{ |c| c.complete! }
  #   self.save
  # end
  
  private
  def comment!(text, user=nil)
    self.comments << Comment.new(
      :comment => text,
      :user => user
    )
    self.save
  end
  
  def log_event
    self.changes.each do |attrib, vals|
      # puts "ATTR: #{attrib}, VALS: #{vals}"
      if ['status_id', :status_id].include?(attrib)
        old_status, new_status = vals.map{ |v| v.blank? ? 'Empty' : Status.find(v).code }
        LeadEvent.new(
          :lead => self, 
          :user => self.owner, 
          :qualifier => "Changed Status from #{old_status} to #{new_status}", 
          :action => 'updated'
        ).save
      else
        old_val, new_val = (vals.count == 2 ? [vals[0], vals[1]] : ['Empty', vals[0]])
        LeadEvent.new(
          :lead => self, 
          :user => self.owner, 
          :qualifier => "Attribute #{attrib.camelize} from #{old_val} to #{new_val}", 
          :action => 'updated'
        ).save
      end
    end
  end
  
  def update_callbacks
   if self.call_backs.present?
      self.call_backs.select{|cb| cb.user == self.owner && cb.status.code == 'UN'}.each do |cb|
        cb.status = CallBackStatus.find_by_code('CP')
        cb.save
      end
    end
  end
end
