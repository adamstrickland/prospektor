# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100101215219) do

  create_table "acs codes", :id => false, :force => true do |t|
    t.integer "ACSCodeID",            :default => 0, :null => false
    t.string  "ACS Code"
    t.string  "ACS Code Description"
  end

  create_table "acs compensation plans", :id => false, :force => true do |t|
    t.integer  "ACSCompID",      :default => 0, :null => false
    t.integer  "MCS Override"
    t.integer  "GO Rate"
    t.string   "JBA"
    t.datetime "SSMA_TimeStamp"
  end

  create_table "acs meeting location", :id => false, :force => true do |t|
    t.integer "ID",       :default => 0, :null => false
    t.string  "Location"
  end

  create_table "acs override rate", :id => false, :force => true do |t|
    t.integer "ACSOverrideRateID"
    t.integer "ACS EmpID"
    t.integer "ACS Emp OverrideRate"
    t.string  "Comment"
  end

  create_table "acs_codes", :force => true do |t|
    t.string "code"
    t.string "description"
  end

  create_table "acs_compensation_plan", :force => true do |t|
    t.integer  "mcs_override"
    t.integer  "go_rate"
    t.string   "jba"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acs_meeting_locations", :force => true do |t|
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acs_override_rates", :force => true do |t|
    t.integer  "acs_override_rate_id"
    t.integer  "acs_emp_id"
    t.integer  "acs_emp_override_rate"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adjustment", :id => false, :force => true do |t|
    t.integer  "PayAdjustmentID"
    t.integer  "EmpID"
    t.datetime "Pay Date"
    t.string   "Adjustment"
    t.string   "Comment"
  end

  create_table "adjustments", :force => true do |t|
    t.integer  "pay_adjustment_id"
    t.integer  "emp_id"
    t.datetime "pay_date"
    t.string   "adjustment"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "analyses", :force => true do |t|
    t.string   "job"
    t.string   "analyst"
    t.string   "acs_status"
    t.string   "mcs_status"
    t.string   "job_status"
    t.string   "ran"
    t.string   "hours_sold"
    t.string   "project"
    t.string   "men"
    t.datetime "mcs_date"
    t.datetime "mcs_time"
    t.string   "comment"
    t.float    "pay_rate"
    t.string   "lcrp_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "analysesview", :id => false, :force => true do |t|
    t.integer  "ID",         :default => 0, :null => false
    t.string   "Job ."
    t.string   "Analyst"
    t.string   "ACS Status"
    t.string   "MCS Status"
    t.string   "Job Status"
    t.string   "Ran"
    t.string   "Hours Sold"
    t.string   "Project"
    t.string   "Men"
    t.datetime "MCS Date"
    t.datetime "MCS Time"
    t.string   "Comment"
    t.float    "PayRate"
    t.string   "LCRP-Email"
  end

  create_table "appointment status", :id => false, :force => true do |t|
    t.integer "AppointmentStatusID"
    t.string  "AppointmentCode"
    t.string  "AppointmentStatusDescription"
    t.string  "BC Contacts"
    t.string  "Sales Appt Codes"
    t.string  "TeleSales Codes"
  end

  create_table "appointment_statuses", :force => true do |t|
    t.integer  "appointment_status_id"
    t.string   "appointment_code"
    t.string   "appointment_status_description"
    t.string   "bc_contacts"
    t.string   "sales_appt_codes"
    t.string   "tele_sales_codes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointments", :force => true do |t|
    t.string   "client_email",                  :null => false
    t.string   "expert_email",                  :null => false
    t.string   "location",                      :null => false
    t.float    "duration",     :default => 1.0, :null => false
    t.text     "notes"
    t.date     "session_date",                  :null => false
    t.time     "session_time",                  :null => false
    t.integer  "lead_id",                       :null => false
    t.integer  "scheduler_id",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topic_id",     :default => 1
  end

  create_table "appointmentsview", :id => false, :force => true do |t|
    t.integer  "AppointmentID",        :default => 0, :null => false
    t.integer  "ContactID"
    t.datetime "CB Date"
    t.datetime "CB Time"
    t.string   "CB Sale Probability"
    t.string   "Comments"
    t.string   "ApptStatus"
    t.string   "Entered"
    t.string   "Closes Attempted"
    t.string   "Call First"
    t.integer  "RepID"
    t.string   "Teleconference"
    t.string   "Pre-Appointment"
    t.string   "e-mailsent"
    t.string   "Lettersent"
    t.string   "Cooperative"
    t.string   "References Requested"
    t.string   "Maintain Contact"
    t.string   "Online Meeting"
    t.datetime "TimeStart"
    t.datetime "TimeEnd"
    t.string   "NoSaleReason"
    t.string   "Problem1"
    t.string   "Impact1"
    t.string   "Problem2"
    t.string   "Impact2"
    t.string   "Problem3"
    t.string   "Impact3"
    t.datetime "Probable ACS Date"
    t.datetime "Probable Sale Date"
  end

  create_table "bc hot buttons", :id => false, :force => true do |t|
    t.integer "ID",           :default => 0, :null => false
    t.string  "SIC Division"
    t.string  "SIC Group"
    t.string  "HB Name"
    t.string  "Question 1"
    t.string  "Question 2"
    t.string  "Question 3"
    t.string  "Question 4"
    t.string  "Question 5"
    t.string  "Question 6"
    t.string  "Question 7"
  end

  create_table "bc_hot_buttons", :force => true do |t|
    t.string   "sic_division"
    t.string   "sic_group"
    t.string   "hb_name"
    t.string   "question_1"
    t.string   "question_2"
    t.string   "question_3"
    t.string   "question_4"
    t.string   "question_5"
    t.string   "question_6"
    t.string   "question_7"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "call_queues", :force => true do |t|
    t.string   "name",       :null => false
    t.date     "queue_date", :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", :force => true do |t|
    t.integer  "job_collections_id"
    t.integer  "job_invoice_id"
    t.datetime "date_received"
    t.float    "amount"
    t.datetime "date_posted"
    t.string   "department"
    t.string   "comment"
    t.string   "job"
    t.string   "mcs_hours_collected"
    t.string   "adjustment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collectionsview", :id => false, :force => true do |t|
    t.integer  "Job Collections ID"
    t.integer  "Job Invoice ID"
    t.datetime "Date Received"
    t.float    "Amount"
    t.datetime "Date Posted"
    t.string   "Department"
    t.string   "Comment"
    t.string   "Job ."
    t.string   "MCS Hours Collected"
    t.string   "Adjustment"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "lead_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "lead_id"
    t.integer  "bcid"
    t.string   "memo"
    t.datetime "date"
    t.datetime "set_date"
    t.datetime "set_time"
    t.string   "status"
    t.datetime "recontact_date"
    t.datetime "recontact_time"
    t.datetime "appt_date"
    t.datetime "appt_time"
    t.string   "confirmed"
    t.string   "faxed"
    t.string   "one_legged"
    t.string   "rcvd"
    t.string   "hot_buttons"
    t.string   "prospect_problems"
    t.string   "discuss_competition"
    t.string   "history_and_success"
    t.string   "knows_bmc"
    t.string   "bad_experience"
    t.string   "prior_consultant"
    t.string   "presentation_scheduled"
    t.string   "presentation_scheduled_set_with"
    t.string   "presentation_viewed"
    t.string   "presentation_score"
    t.datetime "expert_date"
    t.datetime "expert_time"
    t.string   "expert_set_with"
    t.string   "expert_topic"
    t.datetime "expert_timeframe"
    t.datetime "expert_time_confirmation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contactsview", :id => false, :force => true do |t|
    t.integer  "ContactID",                       :default => 0, :null => false
    t.integer  "LeadID"
    t.integer  "BCID"
    t.string   "Memo"
    t.datetime "Date"
    t.datetime "Set Date"
    t.datetime "Set Time"
    t.string   "Status"
    t.datetime "Recontact Date"
    t.datetime "Recontact Time"
    t.datetime "ApptDate"
    t.datetime "ApptTime"
    t.string   "Confirmed"
    t.string   "Faxed"
    t.string   "One-Legged"
    t.string   "Rcvd"
    t.string   "Hot Buttons"
    t.string   "Prospect Problems"
    t.string   "Discuss Competition"
    t.string   "History & Success"
    t.string   "Knows BMC"
    t.string   "Bad Experience"
    t.string   "Prior Consultant"
    t.string   "Presentation Scheduled"
    t.string   "Presentation Scheduled Set With"
    t.string   "Presentation Viewed"
    t.string   "Presentation Score"
    t.datetime "Expert Date"
    t.datetime "Expert Time"
    t.string   "Expert Set With"
    t.string   "Expert Topic"
    t.datetime "Expert Timeframe"
    t.datetime "Expert Time Confirmation"
  end

  create_table "counties", :force => true do |t|
    t.string   "state"
    t.string   "county"
    t.string   "population"
    t.string   "area"
    t.string   "year_2008"
    t.string   "year_2007"
    t.string   "year_2006"
    t.string   "year_2005"
    t.string   "year_2004"
    t.string   "year_2003"
    t.string   "year_2002"
    t.string   "year_2001"
    t.string   "year_2000"
    t.datetime "time_zone"
    t.string   "daylight_savings"
    t.integer  "emp_id"
    t.datetime "date_issued"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countiesview", :id => false, :force => true do |t|
    t.integer  "ID",               :default => 0, :null => false
    t.string   "State"
    t.string   "County"
    t.string   "Population"
    t.string   "Area"
    t.string   "2008"
    t.string   "2007"
    t.string   "2006"
    t.string   "2005"
    t.string   "2004"
    t.string   "2003"
    t.string   "2002"
    t.string   "2001"
    t.string   "2000"
    t.datetime "Time Zone"
    t.string   "Daylight Savings"
    t.integer  "EmpID"
    t.datetime "Date Issued"
  end

  create_table "db failure rates", :id => false, :force => true do |t|
    t.string "SIC Division"
    t.string "SIC Division Description"
    t.string "0-1 Years"
    t.string "2 Years"
    t.string "3 Years"
    t.string "4 Years"
    t.string "5 Years"
    t.string "6 Years"
    t.string "7 Years"
    t.string "8 Years"
    t.string "9 Years"
    t.string "10 Years"
  end

  create_table "db_failure_rates", :force => true do |t|
    t.string   "sic_division"
    t.string   "sic_division_description"
    t.string   "year_1"
    t.string   "year_2"
    t.string   "year_3"
    t.string   "year_4"
    t.string   "year_5"
    t.string   "year_6"
    t.string   "year_7"
    t.string   "year_8"
    t.string   "year_9"
    t.string   "year_10"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emp codes", :id => false, :force => true do |t|
    t.string "Emp Code"
    t.string "Employee Size"
    t.string "RefUSA Employee Size"
  end

  create_table "emp_codes", :force => true do |t|
    t.string   "emp_code"
    t.string   "employee_size"
    t.string   "ref_usa_employee_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.integer  "middle_initial"
    t.string   "preferred_name"
    t.string   "social_security_number"
    t.string   "department_name"
    t.string   "sex"
    t.string   "title"
    t.string   "email_name"
    t.string   "address"
    t.string   "city"
    t.string   "state_or_province"
    t.string   "postal_code"
    t.string   "country"
    t.string   "phone"
    t.string   "fax"
    t.string   "cellular"
    t.string   "expert_scheduler_phone"
    t.datetime "birthdate"
    t.datetime "status_change_date"
    t.datetime "date_hired"
    t.string   "w_2"
    t.string   "married"
    t.string   "spouse_name"
    t.string   "exemptions"
    t.string   "emrgcy_contact_name"
    t.string   "emrgcy_contact_phone"
    t.string   "active"
    t.string   "termination"
    t.string   "reports_to"
    t.integer  "trainer_id"
    t.string   "business_name"
    t.integer  "fed_tax_id"
    t.string   "business_card_name"
    t.string   "emp_ap"
    t.string   "i_9_form"
    t.string   "i_9_i_ds"
    t.string   "liability_insurance"
    t.string   "w_4_form"
    t.string   "policy_signoff"
    t.string   "ewa"
    t.string   "business_proof"
    t.string   "resignation"
    t.string   "notes"
    t.string   "extension"
    t.string   "shift"
    t.string   "program"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employeesview", :id => false, :force => true do |t|
    t.integer  "EmployeeID",             :default => 0, :null => false
    t.string   "LastName"
    t.string   "FirstName"
    t.integer  "MiddleInitial"
    t.string   "PreferredName"
    t.string   "SocialSecurityNumber"
    t.string   "DepartmentName"
    t.string   "Sex"
    t.string   "Title"
    t.string   "EmailName"
    t.string   "Address"
    t.string   "City"
    t.string   "StateOrProvince"
    t.string   "PostalCode"
    t.string   "Country"
    t.string   "Phone"
    t.string   "Fax"
    t.string   "Cellular"
    t.string   "Expert Scheduler Phone"
    t.datetime "Birthdate"
    t.datetime "StatusChangeDate"
    t.datetime "DateHired"
    t.string   "W-2"
    t.string   "Married"
    t.string   "SpouseName"
    t.string   "Exemptions"
    t.string   "EmrgcyContactName"
    t.string   "EmrgcyContactPhone"
    t.string   "Active"
    t.string   "Termination"
    t.string   "ReportsTo"
    t.integer  "TrainerID"
    t.string   "Business Name"
    t.integer  "Fed Tax ID"
    t.string   "Business Card Name"
    t.string   "Emp Ap"
    t.string   "I-9 Form"
    t.string   "I-9 IDs"
    t.string   "Liability Insurance"
    t.string   "W-4 Form"
    t.string   "Policy Signoff"
    t.string   "EWA"
    t.string   "Business Proof"
    t.string   "Resignation"
    t.string   "Notes"
    t.string   "Extension"
    t.string   "Shift"
    t.string   "Program"
    t.string   "Username"
    t.string   "Password"
  end

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "lead_id"
    t.string   "action"
    t.string   "qualifier"
    t.string   "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expense reimbursement", :id => false, :force => true do |t|
    t.integer "Expense ID"
    t.string  "Period Ending"
    t.string  "Expense Reimbursement"
    t.integer "EmpID"
    t.string  "Jobs"
  end

  create_table "expense_reimbursements", :force => true do |t|
    t.integer  "expense_id"
    t.string   "period_ending"
    t.string   "expense_reimbursement"
    t.integer  "emp_id"
    t.string   "jobs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gender", :id => false, :force => true do |t|
    t.string "Gender"
  end

  create_table "genders", :force => true do |t|
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.integer  "job_invoice_id"
    t.string   "job"
    t.integer  "employee_id"
    t.datetime "invoice_date"
    t.float    "amount"
    t.string   "expenses"
    t.integer  "prepaid"
    t.string   "mcs_hours_billed"
    t.float    "billing_rate"
    t.string   "comment"
    t.string   "pd"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobsview", :id => false, :force => true do |t|
    t.integer  "Job Invoice ID"
    t.string   "Job ."
    t.integer  "Employee ID"
    t.datetime "Invoice Date"
    t.float    "Amount"
    t.string   "Expenses"
    t.integer  "Prepaid"
    t.string   "MCS Hours Billed"
    t.float    "Billing Rate"
    t.string   "Comment"
    t.string   "PD"
  end

  create_table "leads", :force => true do |t|
    t.string   "name",                              :null => false
    t.string   "last_name"
    t.string   "first_name"
    t.string   "salutation"
    t.string   "title"
    t.string   "gender",              :limit => 1
    t.string   "company",                           :null => false
    t.integer  "year_established"
    t.string   "address"
    t.string   "city"
    t.string   "state",               :limit => 4
    t.string   "county"
    t.string   "zip",                 :limit => 10
    t.string   "phone",                             :null => false
    t.string   "extension",           :limit => 5
    t.string   "fax",                 :limit => 10
    t.string   "cell_phone",          :limit => 10
    t.integer  "employee_actual"
    t.string   "employee_code"
    t.integer  "sales_actual"
    t.string   "sales_code"
    t.string   "sic_code_1"
    t.string   "sic_description_1"
    t.string   "sic_code_2"
    t.string   "sic_description_2"
    t.string   "sic_code_3"
    t.string   "sic_description_3"
    t.string   "sic_code_4"
    t.string   "sic_description_4"
    t.string   "sic_code_5"
    t.string   "sic_description_5"
    t.string   "msa"
    t.string   "web"
    t.string   "email"
    t.integer  "number_of_pcs"
    t.integer  "square_footage"
    t.boolean  "own_property"
    t.string   "credit_rating"
    t.integer  "credit_score"
    t.string   "source"
    t.datetime "imported_at"
    t.string   "timezone",            :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "aasm_state"
    t.string   "sic_code_6"
    t.string   "sic_description_6"
    t.string   "sic_code_7"
    t.string   "sic_description_7"
    t.string   "sic_code_8"
    t.string   "sic_description_8"
    t.string   "sic_code_9"
    t.string   "sic_description_9"
    t.string   "sic_code_10"
    t.string   "sic_description_10"
    t.string   "naics_code_1"
    t.string   "naics_description_1"
    t.string   "naics_code_2"
    t.string   "naics_description_2"
    t.string   "naics_code_3"
    t.string   "naics_description_3"
    t.string   "naics_code_4"
    t.string   "naics_description_4"
    t.string   "naics_code_5"
    t.string   "naics_description_5"
    t.integer  "status_id"
  end

  add_index "leads", ["company"], :name => "index_leads_on_company"
  add_index "leads", ["name"], :name => "index_leads_on_name"
  add_index "leads", ["phone"], :name => "index_leads_on_phone", :unique => true
  add_index "leads", ["state"], :name => "index_leads_on_state"
  add_index "leads", ["timezone"], :name => "index_leads_on_timezone"

  create_table "leads_users", :id => false, :force => true do |t|
    t.integer  "lead_id",    :null => false
    t.integer  "user_id",    :null => false
    t.string   "context"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mcs codes", :id => false, :force => true do |t|
    t.integer "MCSCodeID"
    t.string  "MCS Code"
    t.string  "MCS Code Description"
  end

  create_table "mcs job status codes", :id => false, :force => true do |t|
    t.integer "MCSJob StatusCodeID"
    t.string  "MCS Job Status"
  end

  create_table "mcs_codes", :force => true do |t|
    t.integer  "mcs_code_id"
    t.string   "mcs_code"
    t.string   "mcs_code_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mcs_job_status_codes", :force => true do |t|
    t.integer  "mcs_job_status_code_id"
    t.string   "mcs_job_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pay", :id => false, :force => true do |t|
    t.integer  "PayID", :default => 0, :null => false
    t.datetime "Date"
    t.integer  "BCID"
    t.string   "Hours"
    t.string   "Pay"
  end

  create_table "pays", :force => true do |t|
    t.datetime "date"
    t.integer  "bcid"
    t.string   "hours"
    t.string   "pay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presentations", :force => true do |t|
    t.string   "email",                                            :null => false
    t.string   "url",                                              :null => false
    t.integer  "lead_id",                                          :null => false
    t.integer  "user_id",                                          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "callback_date", :default => '2009-12-31',          :null => false
    t.time     "callback_time", :default => '2000-01-01 00:04:15', :null => false
  end

  create_table "prior consulting", :id => false, :force => true do |t|
    t.integer "ID",             :default => 0, :null => false
    t.string  "Bad Experience"
  end

  create_table "prior_consultings", :force => true do |t|
    t.string   "bad_experience"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prior_whats", :force => true do |t|
    t.datetime "prior_what"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prior_whos", :force => true do |t|
    t.string   "prior_who"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "priorwhat", :id => false, :force => true do |t|
    t.integer  "ID",        :default => 0, :null => false
    t.datetime "PriorWhat"
  end

  create_table "priorwho", :id => false, :force => true do |t|
    t.integer "ID",       :default => 0, :null => false
    t.string  "PriorWho"
  end

  create_table "project codes", :id => false, :force => true do |t|
    t.integer "ProjectCodeID"
    t.string  "Project"
    t.string  "Description"
  end

  create_table "project_codes", :force => true do |t|
    t.integer  "project_code_id"
    t.string   "project"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "sic_division"
    t.string   "q01"
    t.string   "q02"
    t.string   "q03"
    t.string   "q04"
    t.string   "q05"
    t.string   "q06"
    t.string   "q07"
    t.string   "q08"
    t.string   "q09"
    t.string   "q10"
    t.string   "q11"
    t.string   "q12"
    t.string   "q13"
    t.string   "q14"
    t.string   "q15"
    t.string   "q16"
    t.string   "q17"
    t.string   "q18"
    t.string   "q19"
    t.string   "q20"
    t.string   "q21"
    t.string   "q22"
    t.string   "q23"
    t.string   "q24"
    t.string   "q25"
    t.string   "q26"
    t.string   "q27"
    t.string   "q28"
    t.string   "q29"
    t.string   "q30"
    t.string   "q31"
    t.string   "q32"
    t.string   "q33"
    t.string   "q34"
    t.string   "q35"
    t.string   "q36"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions by leadid", :id => false, :force => true do |t|
    t.integer "LeadID"
    t.string  "SIC Division"
    t.string  "SIC Code"
    t.string  "Q01"
    t.string  "Q02"
    t.string  "Q03"
    t.string  "Q04"
    t.string  "Q05"
    t.string  "Q06"
    t.string  "Q07"
    t.string  "Q08"
    t.string  "Q09"
    t.string  "Q10"
    t.string  "Q11"
    t.string  "Q12"
    t.string  "Q13"
    t.string  "Q14"
    t.string  "Q15"
    t.string  "Q16"
    t.string  "Q17"
    t.string  "Q18"
    t.string  "Q19"
    t.string  "Q20"
    t.string  "Q21"
    t.string  "Q22"
    t.string  "Q23"
    t.string  "Q24"
    t.string  "Q25"
    t.string  "Q26"
    t.string  "Q27"
    t.string  "Q28"
    t.string  "Q29"
    t.string  "Q30"
    t.string  "Q31"
    t.string  "Q32"
    t.string  "Q33"
    t.string  "Q34"
    t.string  "Q35"
    t.string  "Q36"
    t.string  "Question 1"
    t.string  "Question 2"
    t.string  "Question 3"
    t.string  "Question 4"
    t.string  "Question 5"
    t.string  "Question 6"
    t.string  "Question 7"
    t.string  "Question 8"
    t.string  "Question 9"
    t.string  "Question 10"
    t.string  "Question 11"
    t.string  "Question 12"
    t.string  "Question 13"
    t.string  "Question 14"
    t.string  "Question 15"
    t.string  "Question 16"
    t.string  "Question 17"
    t.string  "Question 18"
    t.string  "Question 19"
    t.string  "Question 20"
    t.string  "Question 21"
    t.string  "Question 22"
    t.string  "Question 23"
    t.string  "Question 24"
    t.string  "Question 25"
    t.string  "Question 26"
    t.string  "Question 27"
    t.string  "Question 28"
    t.string  "Question 29"
    t.string  "Question 30"
    t.string  "Question 31"
    t.string  "Question 32"
    t.string  "Question 33"
    t.string  "Question 34"
    t.string  "Question 35"
    t.string  "Question 36"
    t.string  "Question 99"
    t.string  "Question 100"
  end

  create_table "questions for sic code 2752", :id => false, :force => true do |t|
    t.integer "ID",           :default => 0, :null => false
    t.string  "SIC Division"
    t.string  "SIC Code"
    t.string  "Q01"
    t.string  "Q02"
    t.string  "Q03"
    t.string  "Q04"
    t.string  "Q05"
    t.string  "Q06"
    t.string  "Q07"
    t.string  "Q08"
    t.string  "Q09"
    t.string  "Q10"
    t.string  "Q11"
    t.string  "Q12"
    t.string  "Q13"
    t.string  "Q14"
    t.string  "Q15"
    t.string  "Q16"
    t.string  "Q17"
    t.string  "Q18"
    t.string  "Q19"
    t.string  "Q20"
    t.string  "Q21"
    t.string  "Q22"
    t.string  "Q23"
    t.string  "Q24"
    t.string  "Q25"
    t.string  "Q26"
    t.string  "Q27"
    t.string  "Q28"
    t.string  "Q29"
    t.string  "Q30"
    t.string  "Q31"
    t.string  "Q32"
    t.string  "Q33"
    t.string  "Q34"
    t.string  "Q35"
    t.string  "Q36"
  end

  create_table "questions for sic code 3544", :id => false, :force => true do |t|
    t.integer "ID",           :default => 0, :null => false
    t.string  "SIC Division"
    t.string  "SIC Code"
    t.string  "Q01"
    t.string  "Q02"
    t.string  "Q03"
    t.string  "Q04"
    t.string  "Q05"
    t.string  "Q06"
    t.string  "Q07"
    t.string  "Q08"
    t.string  "Q09"
    t.string  "Q10"
    t.string  "Q11"
    t.string  "Q12"
    t.string  "Q13"
    t.string  "Q14"
    t.string  "Q15"
    t.string  "Q16"
    t.string  "Q17"
    t.string  "Q18"
    t.string  "Q19"
    t.string  "Q20"
    t.string  "Q21"
    t.string  "Q22"
    t.string  "Q23"
    t.string  "Q24"
    t.string  "Q25"
    t.string  "Q26"
    t.string  "Q27"
    t.string  "q28"
    t.string  "q29"
    t.string  "q30"
    t.string  "q31"
    t.string  "q32"
    t.string  "q33"
    t.string  "q34"
    t.string  "q35"
    t.string  "q36"
  end

  create_table "questions for sic code 7532", :id => false, :force => true do |t|
    t.string "SIC Division"
    t.string "SIC Code"
    t.string "Q01"
    t.string "Q02"
    t.string "Q03"
    t.string "Q04"
    t.string "Q05"
    t.string "Q06"
    t.string "Q07"
    t.string "Q08"
    t.string "Q09"
    t.string "Q10"
    t.string "Q11"
    t.string "Q12"
    t.string "Q13"
    t.string "Q14"
    t.string "Q15"
    t.string "Q16"
    t.string "Q17"
    t.string "Q18"
    t.string "Q19"
    t.string "Q20"
    t.string "Q21"
    t.string "Q22"
    t.string "Q23"
    t.string "Q24"
    t.string "Q25"
    t.string "Q26"
    t.string "Q27"
    t.string "Q28"
    t.string "Q29"
    t.string "Q30"
    t.string "Q31"
    t.string "Q32"
    t.string "Q33"
    t.string "Q34"
    t.string "Q35"
    t.string "Q36"
  end

  create_table "questions_by_lead_ids", :force => true do |t|
    t.integer  "lead_id"
    t.string   "sic_division"
    t.string   "sic_code"
    t.string   "q01"
    t.string   "q02"
    t.string   "q03"
    t.string   "q04"
    t.string   "q05"
    t.string   "q06"
    t.string   "q07"
    t.string   "q08"
    t.string   "q09"
    t.string   "q10"
    t.string   "q11"
    t.string   "q12"
    t.string   "q13"
    t.string   "q14"
    t.string   "q15"
    t.string   "q16"
    t.string   "q17"
    t.string   "q18"
    t.string   "q19"
    t.string   "q20"
    t.string   "q21"
    t.string   "q22"
    t.string   "q23"
    t.string   "q24"
    t.string   "q25"
    t.string   "q26"
    t.string   "q27"
    t.string   "q28"
    t.string   "q29"
    t.string   "q30"
    t.string   "q31"
    t.string   "q32"
    t.string   "q33"
    t.string   "q34"
    t.string   "q35"
    t.string   "q36"
    t.string   "question_1"
    t.string   "question_2"
    t.string   "question_3"
    t.string   "question_4"
    t.string   "question_5"
    t.string   "question_6"
    t.string   "question_7"
    t.string   "question_8"
    t.string   "question_9"
    t.string   "question_10"
    t.string   "question_11"
    t.string   "question_12"
    t.string   "question_13"
    t.string   "question_14"
    t.string   "question_15"
    t.string   "question_16"
    t.string   "question_17"
    t.string   "question_18"
    t.string   "question_19"
    t.string   "question_20"
    t.string   "question_21"
    t.string   "question_22"
    t.string   "question_23"
    t.string   "question_24"
    t.string   "question_25"
    t.string   "question_26"
    t.string   "question_27"
    t.string   "question_28"
    t.string   "question_29"
    t.string   "question_30"
    t.string   "question_31"
    t.string   "question_32"
    t.string   "question_33"
    t.string   "question_34"
    t.string   "question_35"
    t.string   "question_36"
    t.string   "question_99"
    t.string   "question_100"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions_for_sic_code_2752s", :force => true do |t|
    t.string   "sic_division"
    t.string   "sic_code"
    t.string   "q01"
    t.string   "q02"
    t.string   "q03"
    t.string   "q04"
    t.string   "q05"
    t.string   "q06"
    t.string   "q07"
    t.string   "q08"
    t.string   "q09"
    t.string   "q10"
    t.string   "q11"
    t.string   "q12"
    t.string   "q13"
    t.string   "q14"
    t.string   "q15"
    t.string   "q16"
    t.string   "q17"
    t.string   "q18"
    t.string   "q19"
    t.string   "q20"
    t.string   "q21"
    t.string   "q22"
    t.string   "q23"
    t.string   "q24"
    t.string   "q25"
    t.string   "q26"
    t.string   "q27"
    t.string   "q28"
    t.string   "q29"
    t.string   "q30"
    t.string   "q31"
    t.string   "q32"
    t.string   "q33"
    t.string   "q34"
    t.string   "q35"
    t.string   "q36"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions_for_sic_code_3544s", :force => true do |t|
    t.string   "sic_division"
    t.string   "sic_code"
    t.string   "q01"
    t.string   "q02"
    t.string   "q03"
    t.string   "q04"
    t.string   "q05"
    t.string   "q06"
    t.string   "q07"
    t.string   "q08"
    t.string   "q09"
    t.string   "q10"
    t.string   "q11"
    t.string   "q12"
    t.string   "q13"
    t.string   "q14"
    t.string   "q15"
    t.string   "q16"
    t.string   "q17"
    t.string   "q18"
    t.string   "q19"
    t.string   "q20"
    t.string   "q21"
    t.string   "q22"
    t.string   "q23"
    t.string   "q24"
    t.string   "q25"
    t.string   "q26"
    t.string   "q27"
    t.string   "q28"
    t.string   "q29"
    t.string   "q30"
    t.string   "q31"
    t.string   "q32"
    t.string   "q33"
    t.string   "q34"
    t.string   "q35"
    t.string   "q36"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions_for_sic_code_7532s", :force => true do |t|
    t.string   "sic_division"
    t.string   "sic_code"
    t.string   "q01"
    t.string   "q02"
    t.string   "q03"
    t.string   "q04"
    t.string   "q05"
    t.string   "q06"
    t.string   "q07"
    t.string   "q08"
    t.string   "q09"
    t.string   "q10"
    t.string   "q11"
    t.string   "q12"
    t.string   "q13"
    t.string   "q14"
    t.string   "q15"
    t.string   "q16"
    t.string   "q17"
    t.string   "q18"
    t.string   "q19"
    t.string   "q20"
    t.string   "q21"
    t.string   "q22"
    t.string   "q23"
    t.string   "q24"
    t.string   "q25"
    t.string   "q26"
    t.string   "q27"
    t.string   "q28"
    t.string   "q29"
    t.string   "q30"
    t.string   "q31"
    t.string   "q32"
    t.string   "q33"
    t.string   "q34"
    t.string   "q35"
    t.string   "q36"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questionsview", :id => false, :force => true do |t|
    t.integer "ID",           :default => 0, :null => false
    t.string  "SIC Division"
    t.string  "Q01"
    t.string  "Q02"
    t.string  "Q03"
    t.string  "Q04"
    t.string  "Q05"
    t.string  "Q06"
    t.string  "Q07"
    t.string  "Q08"
    t.string  "Q09"
    t.string  "Q10"
    t.string  "Q11"
    t.string  "Q12"
    t.string  "Q13"
    t.string  "Q14"
    t.string  "Q15"
    t.string  "Q16"
    t.string  "Q17"
    t.string  "Q18"
    t.string  "Q19"
    t.string  "Q20"
    t.string  "Q21"
    t.string  "Q22"
    t.string  "Q23"
    t.string  "Q24"
    t.string  "Q25"
    t.string  "Q26"
    t.string  "Q27"
    t.string  "Q28"
    t.string  "Q29"
    t.string  "Q30"
    t.string  "Q31"
    t.string  "Q32"
    t.string  "Q33"
    t.string  "Q34"
    t.string  "Q35"
    t.string  "Q36"
  end

  create_table "recruiting", :id => false, :force => true do |t|
    t.integer  "Applicant ID"
    t.datetime "Response Date"
    t.datetime "Response Time"
    t.string   "Ad City"
    t.string   "Applicant Name"
    t.string   "Phone"
    t.string   "Screener"
    t.datetime "Screening Date"
    t.string   "Screening Evaluation"
    t.string   "Resume"
    t.string   "TIS"
    t.string   "Interviewer"
    t.datetime "Interview Date"
    t.datetime "Interview Time"
    t.string   "Interview Hotel"
    t.string   "Interview Evaluation"
    t.string   "PIE"
    t.string   "Trainer"
    t.datetime "Training Date"
    t.string   "Training Evaluation"
    t.string   "Comment"
    t.string   "Keirsey"
  end

  create_table "recruitings", :force => true do |t|
    t.integer  "applicant_id"
    t.datetime "response_date"
    t.datetime "response_time"
    t.string   "ad_city"
    t.string   "applicant_name"
    t.string   "phone"
    t.string   "screener"
    t.datetime "screening_date"
    t.string   "screening_evaluation"
    t.string   "resume"
    t.string   "tis"
    t.string   "interviewer"
    t.datetime "interview_date"
    t.datetime "interview_time"
    t.string   "interview_hotel"
    t.string   "interview_evaluation"
    t.string   "pie"
    t.string   "trainer"
    t.datetime "training_date"
    t.string   "training_evaluation"
    t.string   "comment"
    t.string   "keirsey"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", :force => true do |t|
    t.integer  "appointment_id"
    t.string   "client_referenc_number"
    t.string   "booked"
    t.string   "fee"
    t.string   "skd"
    t.string   "skt"
    t.string   "owner2_name"
    t.string   "owner2_title"
    t.string   "owner2_percentage"
    t.string   "owner3_name"
    t.string   "owner3_title"
    t.string   "owner3_percentage"
    t.string   "focus"
    t.integer  "rep_id"
    t.integer  "par_id"
    t.string   "prior_who"
    t.string   "prior_when"
    t.datetime "prior_what"
    t.string   "prior_satisfaction"
    t.string   "emp_l12"
    t.string   "vol_l12"
    t.string   "comment"
    t.string   "confirmed"
    t.string   "expects"
    t.string   "business_description"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salesview", :id => false, :force => true do |t|
    t.integer  "SalesID",              :default => 0, :null => false
    t.integer  "AppointmentID"
    t.string   "ClientReferencNumber"
    t.string   "Booked"
    t.string   "Fee"
    t.string   "Skd"
    t.string   "Skt"
    t.string   "Owner2Name"
    t.string   "Owner2Title"
    t.string   "Owner2%"
    t.string   "Owner3Name"
    t.string   "Owner3Title"
    t.string   "Owner3%"
    t.string   "Focus"
    t.integer  "RepID"
    t.integer  "ParID"
    t.string   "PriorWho"
    t.string   "PriorWhen"
    t.datetime "PriorWhat"
    t.string   "PriorSatisfaction"
    t.string   "EmpL12"
    t.string   "VolL12"
    t.string   "Comment"
    t.string   "Confirmed"
    t.string   "Expects"
    t.string   "Business Description"
    t.string   "Location"
  end

  create_table "schedules", :force => true do |t|
    t.integer  "contact_id"
    t.datetime "cb_date"
    t.datetime "cb_time"
    t.string   "cb_sale_probability"
    t.string   "comments"
    t.string   "appt_status"
    t.string   "entered"
    t.string   "closes_attempted"
    t.string   "call_first"
    t.integer  "rep_id"
    t.string   "teleconference"
    t.string   "pre_appointment"
    t.string   "e_mailsent"
    t.string   "lettersent"
    t.string   "cooperative"
    t.string   "references_requested"
    t.string   "maintain_contact"
    t.string   "online_meeting"
    t.datetime "time_start"
    t.datetime "time_end"
    t.string   "no_sale_reason"
    t.string   "problem1"
    t.string   "impact1"
    t.string   "problem2"
    t.string   "impact2"
    t.string   "problem3"
    t.string   "impact3"
    t.datetime "probable_acs_date"
    t.datetime "probable_sale_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "set with", :id => false, :force => true do |t|
    t.string "Set With"
  end

  create_table "set_withs", :force => true do |t|
    t.string   "set_with"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sic code county data", :id => false, :force => true do |t|
    t.string  "SIC Code"
    t.string  "State"
    t.string  "County"
    t.integer "CountOfLeadID"
    t.string  "CountOfCounty"
    t.integer "SumOfCountOfLeadID"
    t.string  "TEmp2"
    t.string  "TEmp3"
    t.string  "TEmp4"
    t.string  "TEmp5"
    t.string  "TEmp6"
    t.string  "TEmp7"
    t.string  "Temp8"
    t.string  "TVol3"
    t.string  "TVol4"
    t.string  "TVol5"
    t.string  "TVol6"
    t.string  "TVol7"
    t.string  "TVol8"
    t.string  "TCreditE"
    t.string  "TCreditVG"
    t.string  "TCreditG"
  end

  create_table "sic codes", :id => false, :force => true do |t|
    t.string "SIC Division"
    t.string "SIC Code"
    t.string "Description"
    t.string "Acceptable"
    t.string "Emp"
    t.string "Vol"
  end

  create_table "sic_code_county_datas", :force => true do |t|
    t.string   "sic_code"
    t.string   "state"
    t.string   "county"
    t.integer  "count_of_lead_id"
    t.string   "count_of_county"
    t.integer  "sum_of_count_of_lead_id"
    t.string   "t_emp2"
    t.string   "t_emp3"
    t.string   "t_emp4"
    t.string   "t_emp5"
    t.string   "t_emp6"
    t.string   "t_emp7"
    t.string   "temp8"
    t.string   "t_vol3"
    t.string   "t_vol4"
    t.string   "t_vol5"
    t.string   "t_vol6"
    t.string   "t_vol7"
    t.string   "t_vol8"
    t.string   "t_credit_e"
    t.string   "t_credit_vg"
    t.string   "t_credit_g"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sic_codes", :force => true do |t|
    t.string   "sic_division"
    t.string   "sic_code"
    t.string   "description"
    t.string   "acceptable"
    t.string   "emp"
    t.string   "vol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "state sic emp-vol stats", :id => false, :force => true do |t|
    t.string   "State"
    t.string   "SIC Code"
    t.string   "EmpU"
    t.string   "Emp1"
    t.string   "Emp2"
    t.string   "Emp3"
    t.string   "Emp4"
    t.string   "Emp5"
    t.string   "Emp6"
    t.string   "Emp7"
    t.string   "Emp8"
    t.string   "VolU"
    t.string   "Vol1"
    t.string   "Vol2"
    t.string   "Vol3"
    t.string   "Vol4"
    t.string   "Vol5"
    t.string   "Vol6"
    t.string   "Vol7"
    t.string   "Vol8"
    t.datetime "Updated"
  end

  create_table "state_sic_emp_vol_stats", :force => true do |t|
    t.string   "state"
    t.string   "sic_code"
    t.string   "emp_u"
    t.string   "emp1"
    t.string   "emp2"
    t.string   "emp3"
    t.string   "emp4"
    t.string   "emp5"
    t.string   "emp6"
    t.string   "emp7"
    t.string   "emp8"
    t.string   "vol_u"
    t.string   "vol1"
    t.string   "vol2"
    t.string   "vol3"
    t.string   "vol4"
    t.string   "vol5"
    t.string   "vol6"
    t.string   "vol7"
    t.string   "vol8"
    t.datetime "updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.string   "state"
    t.string   "state_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statesview", :id => false, :force => true do |t|
    t.string "State"
    t.string "State Name"
  end

  create_table "statuses", :force => true do |t|
    t.string   "code",        :null => false
    t.string   "description", :null => false
    t.string   "state",       :null => false
    t.string   "context"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time zones", :id => false, :force => true do |t|
    t.datetime "Time Zone"
    t.string   "Description"
  end

  create_table "time_zones", :force => true do |t|
    t.datetime "time_zone"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "title codes", :id => false, :force => true do |t|
    t.string "Title Code"
    t.string "Title"
  end

  create_table "title_codes", :force => true do |t|
    t.string   "title_code"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "name",                            :null => false
    t.boolean  "complimentary", :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
  end

  create_table "touchpoints", :force => true do |t|
    t.integer  "call_queue_id",         :null => false
    t.integer  "lead_id",               :null => false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "call_window_start_at"
    t.datetime "call_window_finish_at"
  end

  create_table "usa sic emp-vol stats", :id => false, :force => true do |t|
    t.string   "SIC Code"
    t.string   "EmpU"
    t.string   "Emp1"
    t.string   "Emp2"
    t.string   "Emp3"
    t.string   "Emp4"
    t.string   "Emp5"
    t.string   "Emp6"
    t.string   "Emp7"
    t.string   "Emp8"
    t.string   "VolU"
    t.string   "Vol1"
    t.string   "Vol2"
    t.string   "Vol3"
    t.string   "Vol4"
    t.string   "Vol5"
    t.string   "Vol6"
    t.string   "Vol7"
    t.string   "Vol8"
    t.datetime "Updated"
  end

  create_table "usa_sic_emp_vol_stats", :force => true do |t|
    t.string   "sic_code"
    t.string   "emp_u"
    t.string   "emp1"
    t.string   "emp2"
    t.string   "emp3"
    t.string   "emp4"
    t.string   "emp5"
    t.string   "emp6"
    t.string   "emp7"
    t.string   "emp8"
    t.string   "vol_u"
    t.string   "vol1"
    t.string   "vol2"
    t.string   "vol3"
    t.string   "vol4"
    t.string   "vol5"
    t.string   "vol6"
    t.string   "vol7"
    t.string   "vol8"
    t.datetime "updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "phone",                                    :default => "2143610080", :null => false
    t.string   "extension"
    t.string   "mobile"
    t.integer  "employee_id"
    t.boolean  "first_time",                               :default => true
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "vol codes", :id => false, :force => true do |t|
    t.string "Vol Code"
    t.float  "Sales Volume"
    t.float  "RefUSA Sales Volume"
  end

  create_table "vol_codes", :force => true do |t|
    t.string   "vol_code"
    t.float    "sales_volume"
    t.float    "ref_usa_sales_volume"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zip codes", :id => false, :force => true do |t|
    t.integer  "ID",        :default => 0, :null => false
    t.string   "Zip"
    t.string   "City"
    t.string   "State"
    t.string   "County"
    t.string   "Area Code"
    t.datetime "Time Zone"
  end

  create_table "zip_codes", :force => true do |t|
    t.string   "zip"
    t.string   "city"
    t.string   "state"
    t.string   "county"
    t.string   "area_code"
    t.datetime "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
