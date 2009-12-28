class CreateZip Codes < ActiveRecord::Migration
  def self.up
    create_table :zip_codes do |t|
      t.integer :id
			t.string :zip
			t.string :city
			t.string :state
			t.string :county
			t.string :area_code
			t.datetime :time_zone
			t.datetime :created_at
			t.timestamps
    end
    execute 'CREATE VIEW Zip Codes ( ID,Zip,City,State,County,Area Code,Time Zone,SSMA_TimeStamp) AS SELECT id,zip,city,state,county,area_code,time_zone,created_at FROM zip_codes'
  end

  def self.down
    execute 'DROP VIEW Zip Codes'
    drop_table :zip_codes
  end
end
