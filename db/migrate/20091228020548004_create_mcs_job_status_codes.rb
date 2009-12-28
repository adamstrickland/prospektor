class CreateMcsJobStatusCodes < ActiveRecord::Migration
  def self.up
    create_table :mcs_job_status_codes do |t|
      t.integer :mcs_job_status_code_id
      t.string :mcs_job_status
      t.timestamps
    end
    execute 'CREATE VIEW `MCS Job Status Codes` ( `MCSJob StatusCodeID`,`MCS Job Status`) AS SELECT mcs_job_status_code_id,mcs_job_status FROM mcs_job_status_codes'
  end
  def self.down
    execute 'DROP VIEW `MCS Job Status Codes`'
    drop_table :mcs_job_status_codes
  end
end