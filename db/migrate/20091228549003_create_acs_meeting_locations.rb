class CreateAcsMeetingLocations < ActiveRecord::Migration
  def self.up
    create_table :acs_meeting_locations do |t|
      t.integer :id
      t.string :location
      t.timestamps
    end
    execute 'CREATE VIEW `ACS Meeting Location` ( `ID`,`Location`) AS SELECT id,location FROM acs_meeting_locations'
  end
  def self.down
    execute 'DROP VIEW `ACS Meeting Location`'
    drop_table :acs_meeting_locations
  end
end