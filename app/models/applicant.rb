class Applicant < ActiveRecord::Base
  validates_presence_of :applicantfirstname, :applicantlastname, :applicantpreferredname, :address, :city, :stateprovince, :zippostalcode, :country, :email, :businessphone
  validates_email :email
  validates_length_of :business_phone, :is => 10
  validates_length_of :mobile_phone, :is => 10, :allow_nil => true, :allow_blank => true
  validates_length_of :home_phone, :is => 10, :allow_nil => true, :allow_blank => true
  
  has_one :employee
  
  alias_attribute :first_name, :applicantfirstname
  alias_attribute :middle_initial, :applicantmi
  alias_attribute :last_name, :applicantlastname
  alias_attribute :preferred_name, :applicantpreferredname
  alias_attribute :social_security_number, :socialsecuritynumber
  alias_attribute :state_province, :stateprovince
  alias_attribute :postal_code, :zippostalcode
  alias_attribute :position_applying_for, :positionapplyingfor
  alias_attribute :home_phone, :homephone
  alias_attribute :mobile_phone, :mobilephone
  alias_attribute :business_phone, :businessphone
  alias_attribute :emergency_contact_name, :emergencycontactname
  alias_attribute :emergency_contact_phone, :emergencycontactphonenum
  alias_attribute :reports_to, :reportstouserid
  alias_attribute :highest_education, :highesteducationachieved
  alias_attribute :years_experience, :positionexperience
  alias_attribute :position_applying_for, :positionapplyingfor
  alias_attribute :consulting_experience_description, :ancillarycomments
  alias_attribute :has_applied_before, :appliedtrigonbefore
  # alias_attribute :contacted_by, :reportstousername
  alias_attribute :how_heard, :howheardoftrigon
  alias_attribute :highest_education, :highesteducationachieved
  alias_attribute :school, :edhistschool1
  alias_attribute :has_internet, :hsinternetconnection
  alias_attribute :work_restrictions, :workrestrictions

  named_scope :non_employee, 
    :conditions => "NOT EXISTS (
      SELECT 1 
      FROM employees 
      WHERE (employees.last_name = applicants.applicantlastname
      AND employees.first_name = applicants.applicantfirstname) OR
      (employees.applicant_id = applicants.id)
    )",
    :order => 'created_at ASC',
    :negative => false
    
  named_scope :non_rejected,
    :conditions => {:rejected => false},
    :order => 'created_at ASC',
    :negative => false
  
  def self.open
    self.non_rejected.non_employee.sort{|f,l| f.created_at <=> l.created_at}
  end 
      
  def before_validation_on_create
    [:home_phone, :business_phone, :mobile_phone].each do |a|
      phone = self.send(a)
      if phone.present?
        self.send("#{a}=".to_sym, phone.gsub(/[^0-9]/, ""))
      end
    end
  end
  
  def create_employee(hire_date=Date.today)
    e = Employee.new
    e.first_name = self.applicantfirstname
    e.middle_initial = self.applicantmi
    e.last_name = self.applicantlastname
    e.preferred_name = self.applicantpreferredname
    e.social_security_number = self.socialsecuritynumber
    # e.gender = self.gender[0].chr.upcase if self.gender else 'M'
    e.gender = (self.gender ? self.gender[0].chr.upcase : 'M')
    e.title = self.positionapplyingfor
    # e.department_name = unless self.positionapplyingfor
    #     'ES'
    #   else
    #     case self.positionapplyingfor.downcase
    #       when 'expert', nil then 'ES'
    #     end
    #   end
    e.department_name = 'AS'
    e.email_name = self.email
    e.address = self.address
    e.city = self.city
    e.state_or_province = self.stateprovince
    e.postal_code = self.zippostalcode
    e.country = ['US','USA'].include?(self.country) ? 'US' : self.country
    e.phone = self.homephone
    e.cellular = self.mobilephone
    e.business_phone = self.businessphone
    e.status_change_date = Date.today
    e.date_hired = hire_date
    e.emrgcy_contact_name = self.emergencycontactname
    e.emrgcy_contact_phone = self.emergencycontactphonenum
    e.active = true
    e.reports_to = self.reportstouserid
    e.applicant = self
    
    if e.save
      e
    end
  end
  
  def full_name
    [self.first_name, (self.preferred_name.present? && self.preferred_name != self.first_name) ? "\"#{self.preferred_name}\"" : nil, self.last_name].compact.join(" ")
  end
end
