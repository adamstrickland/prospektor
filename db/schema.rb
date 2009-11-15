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

ActiveRecord::Schema.define(:version => 20091114231532) do

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

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "lead_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "lead_id"
    t.string   "action"
    t.string   "type"
    t.string   "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leads", :force => true do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "salutation"
    t.string   "title"
    t.string   "gender",            :limit => 1
    t.string   "company"
    t.integer  "year_established"
    t.string   "address"
    t.string   "city"
    t.string   "state",             :limit => 4
    t.string   "county"
    t.string   "zip",               :limit => 10
    t.string   "phone",             :limit => 10
    t.string   "extension",         :limit => 5
    t.string   "fax",               :limit => 10
    t.string   "cell_phone",        :limit => 10
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
    t.string   "timezone",          :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "aasm_state"
    t.integer  "user_id"
  end

  create_table "presentations", :force => true do |t|
    t.string   "email",                                            :null => false
    t.string   "url",                                              :null => false
    t.integer  "lead_id",                                          :null => false
    t.integer  "user_id",                                          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "callback_date", :default => '2009-11-14',          :null => false
    t.time     "callback_time", :default => '2000-01-01 00:17:08', :null => false
  end

  create_table "topics", :force => true do |t|
    t.string   "name",                            :null => false
    t.boolean  "complimentary", :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
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
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
