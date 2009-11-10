require 'digest/sha1'
salt = 

# system:
#   login: system
#   email: system@trigon.com
#   salt: <%= salt %>
#   crypted_password: <%= User.password_digest('monkey', salt) %>
#   created_at: <%= 5.days.ago.to_s :db %>
#   
# adam:
#   login: adam.strickland
#   email: astrickland@trigon.com
#   salt: <%= salt %>
#   crypted_password: <%= User.password_digest('monkey', salt) %>
#   created_at: <%= 5.days.ago.to_s :db %>
#   remember_token_expires_at: <%= 1.days.from_now.to_s :db %>
#   remember_token: <%= salt %>
#   activated_at: <%= 5.days.ago.to_s :db %>
#   name: Adam Strickland


class UsersMapper < Pipeline::TransformMapper
  define_mapping({
    "UserID" => { :to => :id },
    "LastName" => { :to => :name, :transform => lambda{|val, row| "#{row['PreferredName'] ? row['PreferredName'] : row['FirstName']} #{val}"} },
    # "FirstName" => { :to => :firstname },
    # "MiddleInitial" => { :to => :middleinitial },
    # "PreferredName" => { :to => :preferredname },
    # "SocialSecurityNumber" => { :to => :socialsecuritynumber },
    # "Gender" => { :to => :gender },
    "Personal Email Address" => { :to => :email },
    # "Address" => { :to => :address },
    # "City" => { :to => :city },
    # "StateOrProvince" => { :to => :stateorprovince },
    # "PostalCode" => { :to => :postalcode },
    # "Country" => { :to => :country },
    # "Phone" => { :to => :phone },
    # "Cellular" => { :to => :cellular },
    # "ES Direct Phone" => { :to => :es direct phone },
    # "Retained" => { :to => :retained },
    # "EmrgcyContactName" => { :to => :emrgcycontactname },
    # "EmrgcyContactPhone" => { :to => :emrgcycontactphone },
    # "Active" => { :to => :active },
    # "Termination" => { :to => :termination }
    
  })
  post_process do |row_as_hash|
    salt = Digest::SHA1.hexdigest(rand(99).to_s)
    plaintext = generate_password()
    send_plaintext_password(row_as_hash[:email], plaintext)
    crypted_password = User.password_digest(plaintext, salt)
    row_as_hash.merge({
      :salt => salt,
      :crypted_password => crypted_password,
      :updated_at => Date.now,
      :remember_token => salt,
      :remember_token_expires_at => 1.month.from_now.to_s,
      :activation_code => '',
      :activated_at => Date.now
    })
  end
  
  def generate_password
    # ''.join([ string.lowercase[random.Random().randrange(0, 26)] for x in range(0, length) ])
    'abc123DE'
  end
  
  def send_password_email(to_email, plaintext_pwd)
  end
end