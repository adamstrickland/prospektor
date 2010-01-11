require File.join(Rails.root, 'db', 'import', 'prospektor_pipeline')

class LeadsMapper < Pipeline::TransformMapper
  # include ProspektorPipeline
  
  @@user_from_employee = lambda{|emp_id, context|
    u = User.find_by_employee_id(emp_id)
    u ? u.id : nil
  }

  @@phone_from_float = lambda{|val, ctxt|
    val.to_i.to_s
  }

  @@int_from_float = lambda{|val, ctxt|
    val.to_i
  }

  @@downcase = lambda{|val, ctxt|
    val ? val.downcase == "own" : false
  }
  
  @@lookup_status = lambda do |val,ctxt|
    code = case val
      when /Call Back.*/ then "CB"
      when /No Interest.*/, 
           /.*too small/, 
           /.*own consultants/, 
           /.*too busy.*/, 
           /.*40 calls.*/, 
           /.*don't (need)|(know)|(care).*/,
           /.*more business.*/,
           /.*business is different/,
           /We are satisfied.*/,
           /.*xx years/,
           /.*not interested.*/,
           /.*line of business.*/ then
        "NI"
      when /Sale Booked/, /No Show.*/, /Refusal.*/, /Reschedule.*/, /Follow-up Planned/, /Re-Sell.*/ then
        "CLIENT"
      when /Below Minimum Standard.*/ then "BMS"
      when /Bogus/, /Disconnected Number/, /No Good.*/ then "DSC"
      when /Wrong Business Type.*/ then "WBT"
      when /Branch.*/ then "BR"
      when /Do Not Call/ then "DNC"
      when /Duplicate.*/ then "DUP"
      when /Shutting Business Down/, /Selling Business/ then "SBD"
      when /Appointment Set/ then "SET"
      when /No one answered/ then "NA"
      when /Voice Mail/ then "VM"
      else nil
    end
    code.nil? ? nil : Status.find_by_code(code).id
  end
  
  after_save do |fields, data, model|
    Comment.new(:lead => model, :user => model.owner, :comment => data['LastRepAppptComments']).save if data['LastRepAppptComments'] and data['LastRepAppptComments'].length > 0
    Event.find(:all, :conditions => ['lead_id = ?', data['LeadID']]).each do |e|
      e.lead = model
      e.save
    end
    if data['UserID'] and data['UserID'].length > 0
      u = User.find_by_employee_id(data['UserID'].to_i) 
      model.users << u if u and not u.nil?
    end
    # if data['BCID'] and data['BCID'].length > 0
    #   u = User.find_by_employee_id(data['BCID'].to_i)
    #   model.users << u if u and not u.nil?
    # elsif data['BCName'] and data['BCName'].length > 0
    #   u = User.find(:first, :conditions => ['name LIKE ?', "%#{data['BCName']}"])
    #   model.users << u if u and not u.nil?
    # end
    # if data['RepID'] and data['RepID'].length > 0
    #   u = User.find_by_employee_id(data['BCID'].to_i)
    #   model.users << u if u and not u.nil?
    # elsif data['RepName'] and data['RepName'].length > 0
    #   u = User.find(:first, :conditions => ['name LIKE ?', "%#{data['RepName']}"])
    #   model.users << u if u and not u.nil?
    # end
    model.save
  end
  
  define_mappings({
    "LeadID" => { :to => :id },
    "Name" => { :to => :name },
    "Lastname" => { :to => :last_name },
    "Firstname" => { :to => :first_name },
    "Salutation" => { :to => :salutation },
    "Title" => { :to => :title },
    "Gender" => { :to => :gender },
    "Company" => { :to => :company },
    "Year Established" => { :to => :year_established },
    "Address" => { :to => :address },
    "City" => { :to => :city },
    "State" => { :to => :state },
    "County" => { :to => :county },
    "Zip" => { :to => :zip },
    "Phone" => { :to => :phone, :transform => @@phone_from_float },
    "Extension" => { :to => :extension },
    "Fax" => { :to => :fax, :transform => @@phone_from_float },
    "Cell Phone" => { :to => :cell_phone, :transform => @@phone_from_float },
    "Employee Actual" => { :to => :employee_actual },
    "Employee Code" => { :to => :employee_code, :transform => @@int_from_float },
    "Sales Actual" => { :to => :sales_actual },
    "Sales Code" => { :to => :sales_code, :transform => @@int_from_float },
    "SIC Code" => { :to => :sic_code_1 },
    "SIC Description" => { :to => :sic_description_1 },
    "SIC_02" => { :to => :sic_code_2 },
    "DESCRIPTION_02" => { :to => :sic_description_2 },
    "SIC_03" => { :to => :sic_code_3 },
    "DESCRIPTION_03" => { :to => :sic_description_3 },
    "SIC_04" => { :to => :sic_code_4 },
    "DESCRIPTION_04" => { :to => :sic_description_4 },
    "SIC_05" => { :to => :sic_code_5 },
    "DESCRIPTION_05" => { :to => :sic_description_5 },
    "SIC_06" => { :to => :sic_code_6 },
    "DESCRIPTION_06" => { :to => :sic_description_6 },
    "SIC_07" => { :to => :sic_code_7 },
    "DESCRIPTION_07" => { :to => :sic_description_7 },
    "SIC_08" => { :to => :sic_code_8 },
    "DESCRIPTION_08" => { :to => :sic_description_8 },
    "SIC_09" => { :to => :sic_code_9 },
    "DESCRIPTION_09" => { :to => :sic_description_9 },
    "SIC_10" => { :to => :sic_code_10 },
    "DESCRIPTION_10" => { :to => :sic_description_10 },
    "NAICS" => { :to => :naics_code_1 },
    "NAICS DESCRIPTION" => { :to => :naics_description_1 },
    "NAICS2" => { :to => :naics_code_2 },
    "NAICS2 DESCRIPTION" => { :to => :naics_description_2 },
    "NAICS3" => { :to => :naics_code_3 },
    "NAICS3 DESCRIPTION" => { :to => :naics_description_3 },
    "NAICS4" => { :to => :naics_code_4 },
    "NAICS4 DESCRIPTION" => { :to => :naics_description_4 },
    "NAICS5" => { :to => :naics_code_5 },
    "NAICS5 DESCRIPTION" => { :to => :naics_description_5 },
    "MSA" => { :to => :msa },
    "WEB" => { :to => :web },
    "e-mail" => { :to => :email },
    "Number of PCs" => { :to => :number_of_pcs },
    "Square Footage" => { :to => :square_footage },
    "Own or Lease" => { :to => :own_property, :transform => @@downcase },
    "Credit Numeric Score" => { :to => :credit_score },
    "Source" => { :to => :source },
    "Imported" => { :to => :imported_at },
    "Updated" => { :to => :updated_at },
    "Time Zone" => { :to => :timezone },
    # "UserID" => { :to => :user_id, :transform => @@user_from_employee },
    "LastRepApptStatus" => { :to => :status_id, :transform => @@lookup_status }
  })
end