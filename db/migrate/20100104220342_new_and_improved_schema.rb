class NewAndImprovedSchema < ActiveRecord::Migration
  def recreate_table(name, options={}, &block)
    old_name = options[:old].delete || name
    drop_table old_name
    create_table(name, options, &block)
  end
  
  def self.up
    recreate_as :acs_compensation_plans, { :old => :acs_compensation_plan } do |t|
      t.float :rate, :null => false, :default => 0
      t.float :mcs_override, :null => false, :default => 0
      t.integer :jba, :null => false, :default => 0
      t.timestamps
    end
    recreate_table :acs_override_rates do |t|
      t.references :user, :null => false
      t.float :rate, :null => false, :default => 0
      t.timestamps
    end
    create_table :consultation do |t|
      t.datetime :scheduled_at, :null => false
      t.references :user, :as => :expert, :null => false
      t.references :topic, :null => false
      t.boolean :confirmed, :null => false, :default => false
      t.timestamps
    end
    recreate_table :contacts do |t|
      t.references :lead, :null => false
      t.references :user, :null => false
      t.references :status
      t.references :presentation
      t.references :consultation
      t.datetime :set_at
      t.datetime :followup_at
      t.datetime :appointment_at
      t.integer :probability, :null => false, :default => 25
      t.integer :attempts, :null => false, :default => 1
      t.boolean :confirmed, :null => false, :default => false
      t.boolean :faxed, :null => false, :default => false
      t.boolean :one_legged, :null => false, :default => false
      t.boolean :received, :null => false, :default => false
      t.boolean :hot_buttons, :null => false, :default => false
      t.boolean :prospect_problems, :null => false, :default => false
      t.boolean :discuss_competition, :null => false, :default => false
      t.boolean :knows_bmc, :null => false, :default => false
      t.boolean :bad_experience, :null => false, :default => false
      t.boolean :prior_consultant, :null => false, :default => false
      t.boolean :references_requested, :null => false, :default => false
      t.boolean :cooperative, :null => false, :default => false
      t.text :history
      t.text :memo
      t.timestamps
    end
    drop_table :employees
    recreate_table :counties do |t|
      t.references :state, :null => false
      t.references :time_zone, :null => false
      t.boolean :use_daylight_savings, :null => false, :default => tru
      t.string :name, :null => false
      t.integer :area
      (2000..2010).each do |i|
        t.integer "population_#{i}".to_sym
      end
      t.timestamps
    end
    drop_table :collections
    drop_table :appointment_statuses
    drop_table :analyses  # maybe?
    drop_table :adjustments
    drop_table :genders
    drop_table :emp_codes
    recreate_table :d_and_b_failures, :old => :db_failure_rates do |t|
      t.references :sic_division
      (1..10).each do |i|
        t.float "year_#{i}_failure_rate".to_sym
      end
    end
    drop_table :expense_reimbursements
    drop_table :jobs
    recreate_table :mcs_codes do |t|
      t.string :code, :null => false
      t.string :description, :null => false
    end
    drop_table :mcs_job_status_codes
    drop_table :pays
    drop_table :prior_consultings
    create_table :sic_divisions do |t|
      t.string :name, :null => false
    end
    recreate_table :sics, :old => :sic_codes do |t|
      t.references :sic_division, :null => false
      t.string :code, :null => false
      t.string :name, :null => false
      t.boolean :acceptable, :null => false, :default => false
    end
    recreate_table :states do |t|
      t.string :abbrev, :null => false
      t.string :name, :null => false
    end
    recreate_table :time_zones do |t|
      t.string :name, :null => false
      t.integer :offset, :null => false
      t.string :standard_abbrev, :null => false
      t.string :dst_abbrev, :null => false
    end
    drop_table :title_codes
    drop_table :vol_codes
    recreate_table :zips do |t|
      t.string :code, :null => false
      t.references :county, :null => false
      t.string :city
      t.string :area_code
    end
    drop_table :acs_meeting_locations
    drop_table :prior_whats
    recreate_table :priors, :old => :prior_whos do |t|
      t.string :who
      t.datetime :when
      t.string :what
      t.timestamps
    end
    drop_table :set_withs
    recreate_table :competition_data do |t|
      t.references :sic, :null => false
      t.references :county, :null => false
      (1..8).each do |i|
        t.float "headcount_tier_#{i}".to_sym, :null => false, :default => 0
        t.float "sales_tier_#{i}".to_sym, :null => false, :default => 0
      end
      t.timestamps
    end
    recreate_table :bc_hot_buttons do |t|
      t.references :sic, :null => false
      t.string :name, :null => false
      (1..7).each do |i|
        t.string "question_#{i}".to_sym
      end
    end
    recreate_table :questions do |t|
      t.string :text, :null => false
    end
    create_table :questionnaires do |t|
      t.references :sic, :null => false
      t.references :question, :null => false
      t.integer :order
    end
    recreate_table :question_responses, :old => :questions_by_lead_id do |t|
      t.references :lead, :null => false
      t.references :question, :null => false
      t.string :response
      t.timestamps
    end
    drop_table :recruitings
    create_table :problems do |t|
      t.references :lead, :null => false
      t.references :user, :null => false
      t.string :problem, :null => false
      t.string :impact, :null => false
      t.integer :severity, :null => false, :default => 0
      t.integer :priority, :null => false, :default => 0
    end
    recreate_table :schedules do |t|
      t.references :lead, :null => false
      t.references :status
      t.references :user, :null => false
      t.boolean :call_first, :null => false, :default => false
      t.datetime :start_at, :null => false
      t.integer :duration, :null => false, :default => 60
      t.string :address
      t.string :conference_number
      t.string :webcon_url
      t.timestamps
    end
    create_table :owners do |t|
      t.references :clients, :null => false
      t.string :name, :null => false
      t.string :title, :null => false
      t.float :percentage
    end
    create_table :clients do |t|
      t.references :lead, :null => false
      t.string :reference_number, :null => false
    end
    recreate_table :sales do |t|
      t.references :client, :null => false
      t.references :user, :null => false
      t.references :schedule
      t.references :consultation
      t.boolean :booked, :null => false, :default => false
      t.boolean :confirmed, :null => false, :default => false
      t.float :fee, :null => false, :default => 0
      t.string :focus
      t.timestamps
    end
  end

  def self.down
  end
end
