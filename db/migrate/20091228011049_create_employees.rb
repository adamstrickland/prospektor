class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.integer :id
			t.string :last_name
			t.string :first_name
			t.integer :middle_initial
			t.string :preferred_name
			t.string :social_security_number
			t.string :department_name
			t.string :sex
			t.string :title
			t.string :email_name
			t.string :address
			t.string :city
			t.string :state_or_province
			t.string :postal_code
			t.string :country
			t.string :phone
			t.string :fax
			t.string :cellular
			t.string :expert_scheduler_phone
			t.datetime :birthdate
			t.datetime :status_change_date
			t.datetime :date_hired
			t.string :w_2
			t.string :married
			t.string :spouse_name
			t.string :exemptions
			t.string :emrgcy_contact_name
			t.string :emrgcy_contact_phone
			t.string :active
			t.string :termination
			t.string :reports_to
			t.integer :trainer_id
			t.string :business_name
			t.integer :fed_tax_id
			t.string :business_card_name
			t.string :emp_ap
			t.string :i_9_form
			t.string :i_9_i_ds
			t.string :liability_insurance
			t.string :w_4_form
			t.string :policy_signoff
			t.string :ewa
			t.string :business_proof
			t.string :resignation
			t.string :notes
			t.string :extension
			t.string :shift
			t.string :program
			t.datetime :created_at
			t.string :username
			t.string :password
			t.timestamps
    end
    execute 'CREATE VIEW Employees ( EmployeeID,LastName,FirstName,MiddleInitial,PreferredName,SocialSecurityNumber,DepartmentName,Sex,Title,EmailName,Address,City,StateOrProvince,PostalCode,Country,Phone,Fax,Cellular,Expert Scheduler Phone,Birthdate,StatusChangeDate,DateHired,W-2,Married,SpouseName,Exemptions,EmrgcyContactName,EmrgcyContactPhone,Active,Termination,ReportsTo,TrainerID,Business Name,Fed Tax ID,Business Card Name,Emp Ap,I-9 Form,I-9 IDs,Liability Insurance,W-4 Form,Policy Signoff,EWA,Business Proof,Resignation,Notes,Extension,Shift,Program,SSMA_TimeStamp,Username,Password) AS SELECT id,last_name,first_name,middle_initial,preferred_name,social_security_number,department_name,sex,title,email_name,address,city,state_or_province,postal_code,country,phone,fax,cellular,expert_scheduler_phone,birthdate,status_change_date,date_hired,w_2,married,spouse_name,exemptions,emrgcy_contact_name,emrgcy_contact_phone,active,termination,reports_to,trainer_id,business_name,fed_tax_id,business_card_name,emp_ap,i_9_form,i_9_i_ds,liability_insurance,w_4_form,policy_signoff,ewa,business_proof,resignation,notes,extension,shift,program,created_at,username,password FROM employees'
  end

  def self.down
    execute 'DROP VIEW Employees'
    drop_table :employees
  end
end
