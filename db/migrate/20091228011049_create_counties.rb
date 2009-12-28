class CreateCounties < ActiveRecord::Migration
  def self.up
    create_table :counties do |t|
      t.integer :id
			t.string :state
			t.string :county
			t.string :population
			t.string :area
			t.string :2008
			t.string :2007
			t.string :2006
			t.string :2005
			t.string :2004
			t.string :2003
			t.string :2002
			t.string :2001
			t.string :2000
			t.datetime :time_zone
			t.string :daylight_savings
			t.integer :emp_id
			t.datetime :date_issued
			t.datetime :created_at
			t.timestamps
    end
    execute 'CREATE VIEW Counties ( ID,State,County,Population,Area,2008,2007,2006,2005,2004,2003,2002,2001,2000,Time Zone,Daylight Savings,EmpID,Date Issued,SSMA_TimeStamp) AS SELECT id,state,county,population,area,2008,2007,2006,2005,2004,2003,2002,2001,2000,time_zone,daylight_savings,emp_id,date_issued,created_at FROM counties'
  end

  def self.down
    execute 'DROP VIEW Counties'
    drop_table :counties
  end
end
