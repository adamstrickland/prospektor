class CreateBaselineSchema < ActiveRecord::Migration
  def self.up
    create_table "BCR", :force => true do |t|
      t.datetime "date_completed"
      t.string   "phone",            :limit => 10
      t.string   "client_name",      :limit => 45
      t.string   "client_title",     :limit => 45
      t.string   "company",          :limit => 45
      t.string   "general_1",        :limit => 1
      t.string   "general_2",        :limit => 1
      t.string   "general_3",        :limit => 1
      t.string   "general_4",        :limit => 1
      t.string   "employee_1",       :limit => 1
      t.string   "employee_2",       :limit => 1
      t.string   "employee_3",       :limit => 1
      t.string   "employee_4",       :limit => 1
      t.string   "employee_5",       :limit => 1
      t.string   "employee_6",       :limit => 1
      t.string   "finance_1",        :limit => 1
      t.string   "budget_1",         :limit => 1
      t.string   "budget_2",         :limit => 1
      t.string   "budget_3",         :limit => 1
      t.string   "budget_4",         :limit => 1
      t.string   "accounting_1",     :limit => 1
      t.string   "accounting_2",     :limit => 1
      t.string   "accounting_3",     :limit => 1
      t.string   "costs_1",          :limit => 1
      t.string   "costs_2",          :limit => 1
      t.string   "costs_3",          :limit => 1
      t.string   "costs_4",          :limit => 1
      t.string   "costs_5",          :limit => 1
      t.string   "costs_6",          :limit => 1
      t.string   "costs_7",          :limit => 1
      t.string   "sales_1",          :limit => 1
      t.string   "sales_2",          :limit => 1
      t.string   "sales_3",          :limit => 1
      t.string   "sales_4",          :limit => 1
      t.string   "sales_5",          :limit => 1
      t.string   "sales_6",          :limit => 1
      t.string   "sales_7",          :limit => 1
      t.string   "technology_1",     :limit => 1
      t.string   "technology_2",     :limit => 1
      t.string   "technology_3",     :limit => 1
      t.string   "technology_4",     :limit => 1
      t.string   "technology_5",     :limit => 1
      t.string   "manufacturing_1",  :limit => 1
      t.string   "manufacturing_2",  :limit => 1
      t.string   "manufacturing_3",  :limit => 1
      t.string   "manufacturing_4",  :limit => 1
      t.string   "manufacturing_5",  :limit => 1
      t.string   "manufacturing_6",  :limit => 1
      t.string   "manufacturing_7",  :limit => 1
      t.string   "manufacturing_8",  :limit => 1
      t.string   "manufacturing_9",  :limit => 1
      t.string   "manufacturing_10", :limit => 1
      t.string   "manufacturing_11", :limit => 1
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

    create_table "applicant_disposition_status", :force => true do |t|
      t.string "description", :limit => 50, :null => false
    end

    add_index "applicant_disposition_status", ["description"], :name => "description_UNIQUE", :unique => true

  # Could not dump table "applicants" because of following StandardError
  #   Unknown type 'bit(1)' for column 'appliedtrigonbefore'

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

    create_table "emp_codes", :force => true do |t|
      t.string   "emp_code"
      t.string   "employee_size"
      t.string   "ref_usa_employee_size"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

  # Could not dump table "employees" because of following StandardError
  #   Unknown type 'bit(1)' for column 'w_2'

    create_table "events", :force => true do |t|
      t.integer  "user_id"
      t.integer  "lead_id"
      t.string   "action"
      t.string   "qualifier"
      t.string   "params"
      t.datetime "created_at"
      t.datetime "updated_at"
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
    add_index "leads", ["name"], :name => "index_leads_on_name"
    add_index "leads", ["phone"], :name => "index_leads_on_phone", :unique => true
    add_index "leads", ["state"], :name => "index_leads_on_state"
    add_index "leads", ["timezone"], :name => "index_leads_on_timezone"

    create_table "leads_users", :id => false, :force => true do |t|
      t.integer  "lead_id",     :null => false
      t.integer  "employee_id"
      t.string   "context"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "user_id"
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
    end

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

    create_table "statuses", :force => true do |t|
      t.string   "code",        :null => false
      t.string   "description", :null => false
      t.string   "state",       :null => false
      t.string   "context"
      t.datetime "created_at"
      t.datetime "updated_at"
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

    create_table "vol_codes", :force => true do |t|
      t.string   "vol_code"
      t.string   "sales_volume"
      t.string   "ref_usa_sales_volume"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

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

  def self.down
    drop_table "BCR"
    drop_table "acs_codes"
    drop_table "acs_compensation_plan"
    drop_table "acs_meeting_locations"
    drop_table "acs_override_rates"
    drop_table "adjustments"
    drop_table "analyses"
    drop_table "applicant_disposition_status"
    drop_table "appointment_statuses"
    drop_table "appointments"
    drop_table "bc_hot_buttons"
    drop_table "call_queues"
    drop_table "collections"
    drop_table "comments"
    drop_table "contacts"
    drop_table "counties"
    drop_table "db_failure_rates"
    drop_table "emp_codes"
    drop_table "events"
    drop_table "expense_reimbursements"
    drop_table "genders"
    drop_table "jobs"
    drop_table "leads"
    drop_table "leads_users"
    drop_table "mcs_codes"
    drop_table "mcs_job_status_codes"
    drop_table "pays"
    drop_table "presentations"
    drop_table "prior_consultings"
    drop_table "prior_whats"
    drop_table "prior_whos"
    drop_table "project_codes"
    drop_table "questions"
    drop_table "questions_by_lead_ids"
    drop_table "questions_for_sic_code_2752s"
    drop_table "questions_for_sic_code_3544s"
    drop_table "questions_for_sic_code_7532s"
    drop_table "recruitings"
    drop_table "resistances"
    drop_table "sales"
    drop_table "schedules"
    drop_table "set_withs"
    drop_table "sic_code_county_datas"
    drop_table "sic_codes"
    drop_table "state_sic_emp_vol_stats"
    drop_table "states"
    drop_table "statuses"
    drop_table "time_zones"
    drop_table "title_codes"
    drop_table "topics"
    drop_table "touchpoints"
    drop_table "usa_sic_emp_vol_stats"
    drop_table "users"
    drop_table "vol_codes"
    drop_table "zip_codes"

    # employees
    # applicants
  end
end
