class CreateDbFailureRates < ActiveRecord::Migration
  def self.up
    create_table :db_failure_rates do |t|
      t.string :sic_division
      t.string :sic_division_description
      t.string :year_1
      t.string :year_2
      t.string :year_3
      t.string :year_4
      t.string :year_5
      t.string :year_6
      t.string :year_7
      t.string :year_8
      t.string :year_9
      t.string :year_10
      t.timestamps
    end
    execute 'CREATE VIEW `DB Failure Rates` ( `SIC Division`,`SIC Division Description`,`0-1 Years`,`2 Years`,`3 Years`,`4 Years`,`5 Years`,`6 Years`,`7 Years`,`8 Years`,`9 Years`,`10 Years`) AS SELECT sic_division,sic_division_description,year_1,year_2,year_3,year_4,year_5,year_6,year_7,year_8,year_9,year_10 FROM db_failure_rates'
  end
  def self.down
    execute 'DROP VIEW `DB Failure Rates`'
    drop_table :db_failure_rates
  end
end