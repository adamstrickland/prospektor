class CreateSicCodes < ActiveRecord::Migration
  def self.up
    create_table :sic_codes do |t|
      t.string :sic_division
      t.string :sic_code
      t.string :description
      t.string :acceptable
      t.string :emp
      t.string :vol
      t.timestamps
    end
    execute 'CREATE VIEW `SIC Codes` ( `SIC Division`,`SIC Code`,`Description`,`Acceptable`,`Emp`,`Vol`) AS SELECT sic_division,sic_code,description,acceptable,emp,vol FROM sic_codes'
  end
  def self.down
    execute 'DROP VIEW `SIC Codes`'
    drop_table :sic_codes
  end
end