class Employee < ActiveRecord::Base
  has_one :user

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
    last_name = self.last_name.chomp(', Jr.').chomp(', Sr.').gsub(/,\.-\s'/,'').downcase
    first_name = self.first_name.gsub(/,\.-\s'/,'').downcase
    variations = [
      "#{first_name[0].chr}#{last_name}",
      "#{first_name[0].chr}#{self.middle_initial.nil? || self.middle_initial.strip.empty? ? '_' : self.middle_initial[0].chr.downcase}#{last_name}",
      "#{first_name}#{last_name}",
      "#{first_name}.#{last_name}"
    ]
    variations.detect{ |u| User.find_by_login(u).blank? }
  end
  
  def full_name
    [self.preferred_name || self.first_name, self.middle_initial, self.last_name].compact.join(" ")
  end
end
