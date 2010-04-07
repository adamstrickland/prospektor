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

ActiveRecord::Schema.define(:version => 20100407200541) do

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

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.text     "text"
    t.text     "short_text"
    t.text     "help_text"
    t.integer  "weight"
    t.string   "response_class"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.integer  "display_order"
    t.boolean  "is_exclusive"
    t.boolean  "hide_label"
    t.integer  "display_length"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applicants", :force => true do |t|
    t.string   "applicantfirstname",        :limit => 45,                                                           :null => false
    t.string   "applicantmi",               :limit => 1
    t.string   "applicantlastname",         :limit => 45,                                                           :null => false
    t.string   "applicantpreferredname",    :limit => 45
    t.string   "positionapplyingfor",       :limit => 45
    t.string   "address",                   :limit => 45,                                                           :null => false
    t.string   "city",                      :limit => 45,                                                           :null => false
    t.string   "stateprovince",             :limit => 45,                                                           :null => false
    t.string   "zippostalcode",             :limit => 45,                                                           :null => false
    t.string   "country",                   :limit => 45,                                                           :null => false
    t.string   "email",                     :limit => 45,                                                           :null => false
    t.string   "homephone",                 :limit => 10
    t.string   "mobilephone",               :limit => 10
    t.string   "businessphone",             :limit => 10,                                                           :null => false
    t.boolean  "appliedtrigonbefore",                                                            :default => false, :null => false
    t.boolean  "currentlyemployed",                                                              :default => false, :null => false
    t.boolean  "employercontactpermission",                                                      :default => false, :null => false
    t.string   "highesteducationachieved",  :limit => 45
    t.string   "positionexperience",        :limit => 45
    t.string   "howheardoftrigon",          :limit => 45
    t.string   "overallexperience",         :limit => 45
    t.string   "availability",              :limit => 45
    t.string   "refpersonalname1",          :limit => 45
    t.string   "refpersonalname2",          :limit => 45
    t.string   "refpersonalname3",          :limit => 45
    t.string   "refpersonalphonenum1",      :limit => 10
    t.string   "refpersonalphonenum2",      :limit => 10
    t.string   "refpersonalphonenum3",      :limit => 10
    t.integer  "refpersonalyrs1"
    t.integer  "refpersonalyrs2"
    t.integer  "refpersonalyrs3"
    t.string   "refpersonalrelation1",      :limit => 45
    t.string   "refpersonalrelation2",      :limit => 45
    t.string   "refpersonalrelation3",      :limit => 45
    t.string   "refprofessionalname1",      :limit => 45
    t.string   "refprofessionalname2",      :limit => 45
    t.string   "refprofessionalname3",      :limit => 45
    t.string   "refprofessionalphonenum1",  :limit => 10
    t.string   "refprofessionalphonenum2",  :limit => 10
    t.string   "refprofessionalphonenum3",  :limit => 10
    t.string   "refprofessionalposition1",  :limit => 45
    t.string   "refprofessionalposition2",  :limit => 45
    t.string   "refprofessionalposition3",  :limit => 45
    t.string   "refprofessionalrelation1",  :limit => 45
    t.string   "refprofessionalrelation2",  :limit => 45
    t.string   "refprofessionalrelation3",  :limit => 45
    t.string   "computerliteracy",          :limit => 45
    t.integer  "skill_web"
    t.integer  "skill_word"
    t.integer  "skill_outlook"
    t.integer  "skill_excel"
    t.integer  "skill_access"
    t.integer  "skill_powerpoint"
    t.string   "workrestrictions",          :limit => 45
    t.boolean  "hsinternetconnection",                                                           :default => false, :null => false
    t.string   "edhistfrom1",               :limit => 45
    t.string   "edhistfrom2",               :limit => 45
    t.string   "edhistfrom3",               :limit => 45
    t.string   "edhistfrom4",               :limit => 45
    t.string   "edhistto1",                 :limit => 45
    t.string   "edhistto2",                 :limit => 45
    t.string   "edhistto3",                 :limit => 45
    t.string   "edhistto4",                 :limit => 45
    t.string   "edhistschool1",             :limit => 45
    t.string   "edhistschool2",             :limit => 45
    t.string   "edhistschool3",             :limit => 45
    t.string   "edhistschool4",             :limit => 45
    t.boolean  "edhistgraduated1",                                                               :default => false, :null => false
    t.boolean  "edhistgraduated2",                                                               :default => false, :null => false
    t.boolean  "edhistgraduated3",                                                               :default => false, :null => false
    t.boolean  "edhistgraduated4",                                                               :default => false, :null => false
    t.string   "edhistdegree1",             :limit => 45
    t.string   "edhistdegree2",             :limit => 45
    t.string   "edhistdegree3",             :limit => 45
    t.string   "edhistdegree4",             :limit => 45
    t.string   "edhistmajor1",              :limit => 45
    t.string   "edhistmajor2",              :limit => 45
    t.string   "edhistmajor3",              :limit => 45
    t.string   "edhistmajor4",              :limit => 45
    t.string   "emphistfrom1",              :limit => 45
    t.string   "emphistfrom2",              :limit => 45
    t.string   "emphistfrom3",              :limit => 45
    t.string   "emphistfrom4",              :limit => 45
    t.string   "emphistto1",                :limit => 45
    t.string   "emphistto2",                :limit => 45
    t.string   "emphistto3",                :limit => 45
    t.string   "emphistto4",                :limit => 45
    t.string   "emphistemployer1",          :limit => 45
    t.string   "emphistemployer2",          :limit => 45
    t.string   "emphistemployer3",          :limit => 45
    t.string   "emphistemployer4",          :limit => 45
    t.decimal  "emphistincome1",                                  :precision => 19, :scale => 4
    t.decimal  "emphistincome2",                                  :precision => 19, :scale => 4
    t.decimal  "emphistincome3",                                  :precision => 19, :scale => 4
    t.decimal  "emphistincome4",                                  :precision => 19, :scale => 4
    t.string   "emphistposition1",          :limit => 45
    t.string   "emphistposition2",          :limit => 45
    t.string   "emphistposition3",          :limit => 45
    t.string   "emphistposition4",          :limit => 45
    t.string   "emphistreason1",            :limit => 45
    t.string   "emphistreason2",            :limit => 45
    t.string   "emphistreason3",            :limit => 45
    t.string   "emphistreason4",            :limit => 45
    t.text     "ancillarycomments",         :limit => 2147483647
    t.boolean  "icwa_received",                                                                  :default => false, :null => false
    t.boolean  "resume_received",                                                                :default => false, :null => false
    t.string   "socialsecuritynumber",      :limit => 9
    t.string   "emergencycontactname",      :limit => 45
    t.string   "emergencycontactphonenum",  :limit => 10
    t.string   "reportstousername",         :limit => 45
    t.integer  "reportstouserid"
    t.string   "gender",                    :limit => 6
    t.boolean  "has_voip",                                                                       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "rejected",                                                                       :default => false
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
    t.integer  "lead_id",                                                                                          :null => false
    t.integer  "user_id",                                                                                          :null => false
    t.integer  "status_id",                                                                                        :null => false
    t.string   "status_type",                                                     :default => "AppointmentStatus"
    t.datetime "scheduled_at"
    t.integer  "duration",                                                        :default => 0,                   :null => false
    t.integer  "sale_probability",     :limit => 2, :precision => 2, :scale => 0, :default => 0,                   :null => false
    t.string   "no_sale_reason"
    t.boolean  "references_requested",                                            :default => false
    t.string   "problem_1"
    t.integer  "impact_1"
    t.string   "problem_2"
    t.integer  "impact_2"
    t.string   "problem_3"
    t.integer  "impact_3"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "call_backs", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.datetime "callback_at",                        :null => false
    t.integer  "lead_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_id",   :default => 979352484, :null => false
  end

  add_index "call_backs", ["callback_at"], :name => "index_call_backs_on_callback_at"
  add_index "call_backs", ["lead_id"], :name => "index_call_backs_on_lead_id"
  add_index "call_backs", ["user_id", "callback_at"], :name => "index_call_backs_on_user_id_and_callback_at"
  add_index "call_backs", ["user_id", "lead_id"], :name => "index_call_backs_on_user_id_and_lead_id"
  add_index "call_backs", ["user_id"], :name => "index_call_backs_on_user_id"

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
    t.string   "time_zone"
    t.string   "daylight_savings"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "dependencies", :force => true do |t|
    t.integer  "question_id"
    t.integer  "question_group_id"
    t.string   "rule"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dependency_conditions", :force => true do |t|
    t.integer  "dependency_id"
    t.string   "rule_key"
    t.integer  "question_id"
    t.string   "operator"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "middle_initial",         :limit => 1
    t.string   "preferred_name"
    t.string   "social_security_number"
    t.string   "department_name"
    t.string   "gender",                 :limit => 6
    t.string   "title"
    t.string   "email_name"
    t.string   "address"
    t.string   "city"
    t.string   "state_or_province"
    t.string   "postal_code",            :limit => 6
    t.string   "country"
    t.string   "phone",                  :limit => 10
    t.string   "fax",                    :limit => 10
    t.string   "cellular",               :limit => 10
    t.string   "business_phone",         :limit => 10
    t.datetime "birthdate"
    t.datetime "status_change_date"
    t.datetime "date_hired"
    t.boolean  "w_2",                                  :default => false, :null => false
    t.boolean  "married",                              :default => false, :null => false
    t.string   "spouse_name"
    t.string   "exemptions"
    t.string   "emrgcy_contact_name"
    t.string   "emrgcy_contact_phone",   :limit => 10
    t.boolean  "active",                               :default => false, :null => false
    t.datetime "termination"
    t.integer  "reports_to"
    t.integer  "trainer_id"
    t.string   "business_name"
    t.integer  "fed_tax_id"
    t.string   "business_card_name"
    t.boolean  "emp_ap",                               :default => false, :null => false
    t.boolean  "i_9_form",                             :default => false, :null => false
    t.boolean  "i_9_i_ds",                             :default => false, :null => false
    t.boolean  "liability_insurance",                  :default => false, :null => false
    t.boolean  "w_4_form",                             :default => false, :null => false
    t.boolean  "policy_signoff",                       :default => false, :null => false
    t.boolean  "ewa",                                  :default => false, :null => false
    t.boolean  "w_9",                                  :default => false, :null => false
    t.boolean  "business_proof",                       :default => false, :null => false
    t.datetime "resignation"
    t.string   "notes"
    t.integer  "extension"
    t.string   "shift"
    t.string   "program"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "applicant_id"
  end

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "lead_id"
    t.string   "action"
    t.string   "qualifier"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
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

  create_table "leads", :force => true do |t|
    t.string   "name",                              :null => false
    t.string   "first_name"
    t.string   "last_name"
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
    t.string   "phone",               :limit => 10, :null => false
    t.integer  "extension"
    t.string   "fax",                 :limit => 10
    t.string   "cell_phone",          :limit => 10
    t.integer  "employee_actual"
    t.string   "employee_code",       :limit => 2
    t.integer  "sales_actual"
    t.string   "sales_code",          :limit => 2
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
    t.string   "number_of_pcs"
    t.string   "square_footage"
    t.string   "own_property"
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
    t.string   "sic_group_name"
    t.string   "sic_division"
  end

  add_index "leads", ["company"], :name => "index_leads_on_company"
  add_index "leads", ["last_name"], :name => "index_leads_on_last_name"
  add_index "leads", ["name"], :name => "index_leads_on_name"
  add_index "leads", ["phone"], :name => "index_leads_on_phone", :unique => true
  add_index "leads", ["state"], :name => "index_leads_on_state"
  add_index "leads", ["status_id"], :name => "index_leads_on_status_id"
  add_index "leads", ["timezone"], :name => "index_leads_on_timezone"

  create_table "leads_users", :id => false, :force => true do |t|
    t.integer  "lead_id",     :null => false
    t.integer  "employee_id"
    t.string   "context"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "leads_users", ["lead_id"], :name => "index_leads_users_on_lead_id"
  add_index "leads_users", ["user_id"], :name => "index_leads_users_on_user_id"

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

  create_table "merge_schedules", :force => true do |t|
    t.integer  "contact_id"
    t.datetime "cb_date"
    t.datetime "cb_time"
    t.integer  "sale_probability"
    t.string   "comments"
    t.string   "appt_status"
    t.datetime "created_at"
    t.integer  "user_id"
    t.string   "references_requested"
    t.string   "no_sale_reason"
    t.string   "problem1"
    t.string   "impact1"
    t.string   "problem2"
    t.string   "impact2"
    t.string   "problem3"
    t.string   "impact3"
    t.datetime "updated_at"
    t.string   "entered",              :limit => 45
    t.datetime "callback_at"
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
    t.date     "callback_date", :default => '2009-12-28',          :null => false
    t.time     "callback_time", :default => '2000-01-01 09:34:28', :null => false
    t.integer  "topic_id"
  end

  add_index "presentations", ["topic_id"], :name => "index_presentations_on_topic_id"

  create_table "prior_consultings", :force => true do |t|
    t.string   "bad_experience"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prior_whats", :force => true do |t|
    t.string   "prior_what", :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prior_whos", :force => true do |t|
    t.string   "prior_who"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_codes", :force => true do |t|
    t.integer  "project_code_id"
    t.string   "project"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_groups", :force => true do |t|
    t.text     "text"
    t.text     "help_text"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.string   "display_type"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "survey_section_id"
    t.integer  "question_group_id"
    t.text     "text"
    t.text     "short_text"
    t.text     "help_text"
    t.string   "pick"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.integer  "display_order"
    t.string   "display_type"
    t.boolean  "is_mandatory"
    t.integer  "display_width"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "correct_answer_id"
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

  create_table "resistances", :force => true do |t|
    t.string "resistance", :limit => 45, :null => false
  end

  create_table "response_sets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "survey_id"
    t.string   "access_code"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lead_id"
  end

  add_index "response_sets", ["lead_id"], :name => "index_response_sets_on_lead_id"

  create_table "responses", :force => true do |t|
    t.integer  "response_set_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.string   "response_group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :null => false
    t.integer "user_id", :null => false
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

  create_table "schedules", :force => true do |t|
    t.integer  "contact_id"
    t.datetime "cb_date"
    t.datetime "cb_time"
    t.integer  "sale_probability"
    t.string   "comments"
    t.string   "appt_status"
    t.datetime "created_at"
    t.integer  "user_id"
    t.string   "references_requested"
    t.string   "no_sale_reason"
    t.string   "problem1"
    t.string   "impact1"
    t.string   "problem2"
    t.string   "impact2"
    t.string   "problem3"
    t.string   "impact3"
    t.datetime "updated_at"
    t.string   "entered",              :limit => 45
    t.datetime "callback_at"
  end

  create_table "set_withs", :force => true do |t|
    t.string   "set_with"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "acceptable",   :limit => 3
    t.string   "emp",          :limit => 2
    t.string   "vol",          :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sic_codes", ["sic_code"], :name => "uindex_sic_codes_on_sic_code", :unique => true
  add_index "sic_codes", ["sic_division"], :name => "index_sic_codes_on_sic_division"

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
    t.string   "state",        :limit => 2, :null => false
    t.string   "state_name",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "time_zone_id",              :null => false
  end

  add_index "states", ["time_zone_id"], :name => "index_states_on_time_zone_id"

  create_table "statuses", :force => true do |t|
    t.string   "code",        :null => false
    t.string   "description", :null => false
    t.string   "state",       :null => false
    t.string   "context"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",        :null => false
  end

  add_index "statuses", ["code"], :name => "index_statuses_on_code"
  add_index "statuses", ["state"], :name => "index_statuses_on_state"
  add_index "statuses", ["type"], :name => "index_status_type"

  create_table "survey_sections", :force => true do |t|
    t.integer  "survey_id"
    t.string   "title"
    t.text     "description"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.integer  "display_order"
    t.string   "custom_class"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "access_code"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.datetime "active_at"
    t.datetime "inactive_at"
    t.string   "css_url"
    t.string   "custom_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "display_order"
  end

  create_table "time_zones", :force => true do |t|
    t.string   "time_zone",   :limit => 1
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "type"
    t.string   "information"
  end

  add_index "topics", ["type"], :name => "index_topics_on_type"

  create_table "touchpoints", :force => true do |t|
    t.integer  "call_queue_id",         :null => false
    t.integer  "lead_id",               :null => false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "call_window_start_at"
    t.datetime "call_window_finish_at"
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
    t.boolean  "nda_accepted",                             :default => false
  end

  add_index "users", ["employee_id"], :name => "index_users_on_employee_id"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "validation_conditions", :force => true do |t|
    t.integer  "validation_id"
    t.string   "rule_key"
    t.string   "operator"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.string   "regexp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "validations", :force => true do |t|
    t.integer  "answer_id"
    t.string   "rule"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "name",             :null => false
    t.string   "url",              :null => false
    t.string   "on_complete_hook"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vol_codes", :force => true do |t|
    t.string   "vol_code"
    t.string   "sales_volume"
    t.string   "ref_usa_sales_volume"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wiki_page_versions", :force => true do |t|
    t.integer  "page_id",    :null => false
    t.integer  "updator_id"
    t.integer  "number"
    t.string   "comment"
    t.string   "path"
    t.string   "title"
    t.text     "content"
    t.datetime "updated_at"
  end

  add_index "wiki_page_versions", ["page_id"], :name => "index_wiki_page_versions_on_page_id"
  add_index "wiki_page_versions", ["updator_id"], :name => "index_wiki_page_versions_on_updator_id"

  create_table "wiki_pages", :force => true do |t|
    t.integer  "creator_id"
    t.integer  "updator_id"
    t.string   "path"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wiki_pages", ["creator_id"], :name => "index_wiki_pages_on_creator_id"
  add_index "wiki_pages", ["path"], :name => "index_wiki_pages_on_path", :unique => true

  create_table "zip_codes", :force => true do |t|
    t.string   "zip",                     :null => false
    t.string   "city",                    :null => false
    t.string   "state",                   :null => false
    t.string   "county",                  :null => false
    t.string   "area_code",               :null => false
    t.string   "time_zone",  :limit => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zip_codes", ["zip"], :name => "zip_UNIQUE", :unique => true

end
