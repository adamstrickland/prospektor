require 'digest/sha1'

class UserObserver < ActiveRecord::Observer
  def after_create(user)
    true
  end

  def after_save(user)
    true
  end
end

class UsersMapper < Pipeline::TransformMapper
  @cryptify = lambda{ |val, ctxt| 
    pwd = val || (0...8).map{ ('a'..'z').to_a[rand(26)] }.join
    User.password_digest(pwd.strip, @saltify.call(val, ctxt))
  }
  @saltify = lambda{ |val, ctxt| Digest::SHA1.hexdigest("Religions die when they are proved to be true. Science is the record of dead religions.") }
  
  post_process do |fields, data, attribs, options|
    attribs[:name] = "#{(data['PreferredName'] || data['FirstName'])} #{data['LastName']}"
  end
    
  define_mappings({
    'EmployeeID' => { :to => :id},
    'Username' => { :to => :login },
    'EmailName' => { :to => :email },
    'SocialSecurityNumber' => { :to => :salt, :transform => @saltify },
    'Password' => { :to => :crypted_password, :transform => @cryptify },
    'DateHired' => { :to => :created_at, :transform => lambda{|val, ctxt| (val ? Date.strptime(val, '%m/%d/%Y %H:%M:%S') : Time.now).to_s :db} },
    #placeholders
    'SpouseName' => { :to => :remember_token, :transform => @saltify },
    'Married' => { :to => :remember_token_expires_at, :transform => lambda{ |val,ctxt| 1.days.from_now.to_s :db}},
    # 'Active' => { :to => :activated_at},
    'Active' => { :to => :activated_at, :transform => lambda{ |val, ctxt| (val && val.to_s == '1') ? Time.now.to_s(:db) : nil}},
    'PreferredName' => { :to => :name }    
    # 'LastName' => { :to => :last_name},
    # 'FirstName' => { :to => :first_name},
    # 'MiddleInitial' => { :to => :middle_initial},
    # 'PreferredName' => { :to => :preferred_name},
    # 'SocialSecurityNumber' => { :to => :social_security_number},
    # 'DepartmentName' => { :to => :department_name},
    # 'Sex' => { :to => :sex},
    # 'Title' => { :to => :title},
    # 'EmailName' => { :to => :email_name},
    # 'Address' => { :to => :address},
    # 'City' => { :to => :city},
    # 'StateOrProvince' => { :to => :state_or_province},
    # 'PostalCode' => { :to => :postal_code},
    # 'Country' => { :to => :country},
    # 'Phone' => { :to => :phone},
    # 'Fax' => { :to => :fax},
    # 'Cellular' => { :to => :cellular},
    # 'Expert Scheduler Phone' => { :to => :expert_scheduler_phone},
    # 'Birthdate' => { :to => :birthdate},
    # 'StatusChangeDate' => { :to => :status_change_date},
    # 'DateHired' => { :to => :date_hired},
    # 'W-2' => { :to => :w_2},
    # 'Married' => { :to => :married},
    # 'SpouseName' => { :to => :spouse_name},
    # 'Exemptions' => { :to => :exemptions},
    # 'EmrgcyContactName' => { :to => :emrgcy_contact_name},
    # 'EmrgcyContactPhone' => { :to => :emrgcy_contact_phone},
    # 'Active' => { :to => :active},
    # 'Termination' => { :to => :termination},
    # 'ReportsTo' => { :to => :reports_to},
    # 'TrainerID' => { :to => :trainer_id},
    # 'Business Name' => { :to => :business_name},
    # 'Fed Tax ID' => { :to => :fed_tax_id},
    # 'Business Card Name' => { :to => :business_card_name},
    # 'Emp Ap' => { :to => :emp_ap},
    # 'I-9 Form' => { :to => :i_9_form},
    # 'I-9 IDs' => { :to => :i_9_i_ds},
    # 'Liability Insurance' => { :to => :liability_insurance},
    # 'W-4 Form' => { :to => :w_4_form},
    # 'Policy Signoff' => { :to => :policy_signoff},
    # 'EWA' => { :to => :ewa},
    # 'Business Proof' => { :to => :business_proof},
    # 'Resignation' => { :to => :resignation},
    # 'Notes' => { :to => :notes},
    # 'Extension' => { :to => :extension},
    # 'Shift' => { :to => :shift},
    # 'Program' => { :to => :program},
    # 'Username' => { :to => :username},
    # 'Password' => { :to => :password},
  })
end