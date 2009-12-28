class CreateDb Failure Rates < ActiveRecord::Migration
  def self.up
    create_table :db_failure_rates do |t|
      t.string :sic_division
			t.string :sic_division_description
			t.string :0_1_years
			t.string :2_years
			t.string :3_years
			t.string :4_years
			t.string :5_years
			t.string :6_years
			t.string :7_years
			t.string :8_years
			t.string :9_years
			t.string :10_years
			t.datetime :created_at
			t.timestamps
    end
    execute 'CREATE VIEW DB Failure Rates ( SIC Division,SIC Division Description,0-1 Years,2 Years,3 Years,4 Years,5 Years,6 Years,7 Years,8 Years,9 Years,10 Years,SSMA_TimeStamp) AS SELECT sic_division,sic_division_description,0_1_years,2_years,3_years,4_years,5_years,6_years,7_years,8_years,9_years,10_years,created_at FROM db_failure_rates'
  end

  def self.down
    execute 'DROP VIEW DB Failure Rates'
    drop_table :db_failure_rates
  end
end
