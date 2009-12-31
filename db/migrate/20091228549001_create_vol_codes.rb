class CreateVolCodes < ActiveRecord::Migration
  def self.up
    create_table :vol_codes do |t|
      t.string :vol_code
      t.float :sales_volume
      t.float :ref_usa_sales_volume
      t.timestamps
    end
    execute 'CREATE VIEW `Vol Codes` ( `Vol Code`,`Sales Volume`,`RefUSA Sales Volume`) AS SELECT vol_code,sales_volume,ref_usa_sales_volume FROM vol_codes'
  end
  def self.down
    execute 'DROP VIEW `Vol Codes`'
    drop_table :vol_codes
  end
end