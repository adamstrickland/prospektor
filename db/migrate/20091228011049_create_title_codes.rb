class CreateTitle Codes < ActiveRecord::Migration
  def self.up
    create_table :title_codes do |t|
      t.string :title_code
			t.string :title
			t.datetime :created_at
			t.timestamps
    end
    execute 'CREATE VIEW Title Codes ( Title Code,Title,SSMA_TimeStamp) AS SELECT title_code,title,created_at FROM title_codes'
  end

  def self.down
    execute 'DROP VIEW Title Codes'
    drop_table :title_codes
  end
end
