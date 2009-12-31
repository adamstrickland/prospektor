class CreateTimeZones < ActiveRecord::Migration
  def self.up
    create_table :time_zones do |t|
      t.datetime :time_zone
      t.string :description
      t.timestamps
    end
    execute 'CREATE VIEW `Time Zones` ( `Time Zone`,`Description`) AS SELECT time_zone,description FROM time_zones'
  end
  def self.down
    execute 'DROP VIEW `Time Zones`'
    drop_table :time_zones
  end
end