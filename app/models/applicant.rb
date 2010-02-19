class Applicant < ActiveRecord::Base
  validates_presence_of :applicantfirstname, :applicantlastname, :address, :city, :stateprovince, :zippostalcode, :country, :email, :businessphone
  validates_email :email
  
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

  named_scope :open, :conditions => " NOT EXISTS (
                                      SELECT 1 
                                      FROM employees 
                                      WHERE employees.last_name = applicants.applicantlastname
                                      AND employees.first_name = applicants.applicantfirstname
                                    )"
  
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
    e.department_name = 'ES'
    e.email_name = self.email
    e.address = self.address
    e.city = self.city
    e.state_or_province = self.stateprovince
    e.postal_code = self.zippostalcode
    e.country = ['US','USA'].include?(self.country) ? 'USA' : self.country
    e.phone = self.homephone
    e.cellular = self.mobilephone
    e.business_phone = self.businessphone
    e.status_change_date = Date.today
    e.date_hired = hire_date
    e.emrgcy_contact_name = self.emergencycontactname
    e.emrgcy_contact_phone = self.emergencycontactphonenum
    e.active = true
    e.reports_to = self.reportstouserid
    
    if e.save
      e
    end
  end
  
  def full_name
    [self.first_name, (self.preferred_name.present? && self.preferred_name != self.first_name) ? "\"#{self.preferred_name}\"" : nil, self.last_name].compact.join(" ")
  end
end
