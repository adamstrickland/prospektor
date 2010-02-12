class Applicant < ActiveRecord::Base
  validates_presence_of :applicantfirstname, :applicantlastname, :address, :city, :stateprovince, :zippostalcode, :country, :email, :businessphone

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
    "#{self.applicantlastname}, #{[self.applicantfirstname, "#{self.applicantpreferredname}", self.applicantmi].compact.join(" ")}"
  end
end
