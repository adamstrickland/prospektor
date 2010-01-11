class Employee < ActiveRecord::Base
  has_one :user

  def create_user
    u = User.new
    u.employee = e
    u.login = self.create_username
    pwd = User.generate_password
    u.password = pwd
    u.password_confirmation = pwd
    u.email = self.email
    u.save

    u.activate!
  end 

  def create_username
    lastname = self.applicantlastname.chomp(', Jr.').chomp(', Sr.').gsub(/,\.-\s'/,'').downcase
    firstname = self.applicantfirstname.gsub(/,\.-\s'/,'').downcase
    username = [
      "#{first_name[0].chr}#{last_name}",
      "#{first_name}#{last_name}",
      "#{first_name}.#{last_name}"
    ].detect do |uname| 
      User.find_by_login(uname).blank?
    end
    username
  end

  def try_username(username)
    User.find_by_login(username).blank?
  end
end
