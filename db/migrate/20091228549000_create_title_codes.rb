class CreateTitleCodes < ActiveRecord::Migration
  def self.up
    create_table :title_codes do |t|
      t.string :title_code
      t.string :title
      t.timestamps
    end
    execute 'CREATE VIEW `Title Codes` ( `Title Code`,`Title`) AS SELECT title_code,title FROM title_codes'
  end
  def self.down
    execute 'DROP VIEW `Title Codes`'
    drop_table :title_codes
  end
end