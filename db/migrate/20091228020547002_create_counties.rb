class CreateCounties < ActiveRecord::Migration
  def self.up
    create_table :counties do |t|
      t.integer :id
      t.string :state
      t.string :county
      t.string :population
      t.string :area
      t.string :year_2008
      t.string :year_2007
      t.string :year_2006
      t.string :year_2005
      t.string :year_2004
      t.string :year_2003
      t.string :year_2002
      t.string :year_2001
      t.string :year_2000
      t.datetime :time_zone
      t.string :daylight_savings
      t.integer :emp_id
      t.datetime :date_issued
      t.timestamps
    end
    execute 'CREATE VIEW `CountiesView` ( `ID`,`State`,`County`,`Population`,`Area`,`2008`,`2007`,`2006`,`2005`,`2004`,`2003`,`2002`,`2001`,`2000`,`Time Zone`,`Daylight Savings`,`EmpID`,`Date Issued`) AS SELECT id,state,county,population,area,year_2008,year_2007,year_2006,year_2005,year_2004,year_2003,year_2002,year_2001,year_2000,time_zone,daylight_savings,emp_id,date_issued FROM counties'
  end
  def self.down
    execute 'DROP VIEW `CountiesView`'
    drop_table :counties
  end
end