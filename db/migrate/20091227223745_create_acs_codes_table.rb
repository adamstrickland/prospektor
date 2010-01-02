class CreateAcsCodesTable < ActiveRecord::Migration
  def self.up
    create_table :acs_codes do |t|
      t.string :code
      t.string :description
    end
    # create_view "ACS Codes", "select * from acs_codes" do |v|
    #   v.column "ACS Code"
    #   v.column "ACS Code Description"
    # end
    execute 'CREATE VIEW `ACS Codes` ( `ACSCodeID`,`ACS Code`,`ACS Code Description`) AS SELECT * FROM acs_codes'
  end

  def self.down
    drop_table :acs_codes
    execute 'DROP VIEW `ACS Codes`'
  end
end
