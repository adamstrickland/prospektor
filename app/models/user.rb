require 'chronic'
require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_and_belongs_to_many :roles
  has_and_belongs_to_many :leads
  alias_attribute :assignments, :leads
  has_many :presentations
  has_many :appointments
  has_many :events
  has_many :comments
  has_many :call_queues
  belongs_to :employee
  has_many :call_backs
  alias_attribute :callbacks, :call_backs
  
  validates_length_of :phone, :maximum => 10
  validates_length_of :mobile, :maximum => 10, :allow_nil => true
  
  def next_lead_in_queue
    # if self.call_backs.present? and (uncalled = self.call_backs.window(3.minutes.from_now, Chronic.parse("#{Date.today} 12:00am")).uncalled)
    if self.call_backs.present?
      uncalled = self.call_backs.window(3.minutes.from_now, Chronic.parse("#{Date.today} 12:00am")).uncalled
      return uncalled.first.lead if uncalled.present?
      # uncalled.sort_by{ |f,l|
      #    [f.callback_at, f.created_at] <=> [l.callback_at, l.created_at]
      #  }.first.lead
      # uncalled.first.lead
    end
      
    self.pool.first
  end
  
  def pool
    # self.leads.valid.sort{|f,l| (f.status and l.status) ? f.updated_at <=> l.updated_at : (l.status ? -1 : 1) }
    self.leads.untouched + self.leads.touched
  end
  
  def has_role?(role)
    self.roles.map(&:title).include?(role)
  end
  
  def is_admin?
    self.has_role?('admin')
  end
  
  def official_phone
    default_phone = '214-361-0080'
    if self.employee
      phone = (self.employee.business_phone || self.phone || default_phone).gsub(/-/, "")
      ext = self.employee.extension || self.extension
      if ext.present?
        ext = "x#{ext}"
      else
        ext = ''
      end
      "#{phone[0..2]}-#{phone[3..5]}-#{phone[6..-1]}#{ext}"
    else
      default_phone
    end
  end
  # 
  # def callbacks
  #   # self.leads.callbacks(Time.now)
  # end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def ready_leads(amount=0)
    # self.leads.select{|l| l.status.nil? or l.status.state == 'assigned'}.sort{ |l,r| l.updated_at <=> r.updated_at }[0..(amount-1)]
    good_status_leads = self.leads.select{|l| l.status.nil? or l.status.state == 'assigned'}
    
    # foo.sort{|a,b|( a and b ) ? a <=> b : ( a ? -1 : 1 ) }
    sorted_leads = good_status_leads.sort{ |l,r| 
      if (l.updated_at and r.updated_at)
        l.updated_at <=> r.updated_at
      else
        l.updated_at ? -1 : 1
      end
    }
    sorted_leads[0..(amount-1)]
  end

  def name
    unless self.employee.blank?
      "#{self.employee.preferred_name} #{self.employee.last_name}"
    else
      self.login
    end
  end

  def self.generate_password(size=8)
    (0..(size-1)).map{ (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a)[rand((26+26+10))] }.join
  end
  
  # def assignments
  #   self.leads
  # end
  # 
  # def assignments=(val)
  #   self.leads = val
  # end
  
  def deactivate
    self.activation_code = 'DEACTIVATED'
    self.activated_at = nil
  end
  
  def deactivate!
    self.deactivate
    self.save
  end
  
  
  
  
  
  # RESTful_authentication stuff...

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  before_create :make_activation_code 

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation


  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  protected
    def make_activation_code
      self.activation_code = self.class.make_token
    end
end
