class CreateMcs Codes < ActiveRecord::Migration
  def self.up
    create_table :mcs_codes do |t|
      t.integer :mcs_code_id
			t.string :mcs_code
			t.string :mcs_code_description
			t.timestamps
    end
    execute 'CREATE VIEW MCS Codes ( MCSCodeID,MCS Code,MCS Code Description) AS SELECT mcs_code_id,mcs_code,mcs_code_description FROM mcs_codes'
  end

  def self.down
    execute 'DROP VIEW MCS Codes'
    drop_table :mcs_codes
  end
end
