class CreateAcs Override Rates < ActiveRecord::Migration
  def self.up
    create_table :acs_override_rates do |t|
      t.integer :acs_override_rate_id
t.integer :acs_emp_id
t.integer :acs_emp_override_rate
t.string :comment
t.datetime :created_at
t.timestamps
    end
    execute 'CREATE VIEW ACS Override Rate ( ACSOverrideRateID,ACS EmpID,ACS Emp OverrideRate,Comment,SSMA_TimeStamp) AS SELECT acs_override_rate_id,acs_emp_id,acs_emp_override_rate,comment,created_at FROM acs_override_rates'
  end

  def self.down
    execute 'DROP VIEW ACS Override Rate'
    drop_table :acs_override_rates
  end
end
