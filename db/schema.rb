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

ActiveRecord::Schema.define(:version => 20091029192348) do

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
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
