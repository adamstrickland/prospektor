class Employee < ActiveRecord::Base
  has_one :user
  belongs_to :applicant
  
  alias_attribute :email, :email_name

  def create_user
    u = User.new
    u.employee = self
    u.login = self.generate_username
    pwd = User.generate_password
    u.password = pwd
    u.password_confirmation = pwd
    u.email = self.email_name
    
    if u.save
      if u.activate!
        u
      else
        logger.error("User #{u.id} created but not activated")
        nil
      end
    else  
      logger.error("User for Employee #{self.id} could not be created")
      nil
    end
  end 

  def generate_username    
    User.create_login_from_names(self.first_name, self.last_name, self.middle_initial)
  end
  
  def full_name
    [self.preferred_name || self.first_name, self.middle_initial, self.last_name].compact.join(" ")
  end
end
