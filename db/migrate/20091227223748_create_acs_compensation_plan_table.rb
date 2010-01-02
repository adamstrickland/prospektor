class CreateAcsCompensationPlanTable < ActiveRecord::Migration
  def self.up
    create_table :acs_compensation_plan do |t|
      t.integer :mcs_override
      t.integer :go_rate
      t.string :jba
      t.timestamps
    end
    execute 'CREATE VIEW `ACS Compensation Plans` ( `ACSCompID`,`MCS Override`,`GO Rate`,`JBA`,`SSMA_TimeStamp`) AS SELECT id, mcs_override, go_rate, jba, created_at FROM acs_compensation_plan'
  end

  def self.down
    drop_table :acs_compensation_plan
    execute 'DROP VIEW `ACS Compensation Plans`'
  end
end
