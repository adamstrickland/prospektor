class CreateGenders < ActiveRecord::Migration
  def self.up
    create_table :genders do |t|
      t.string :gender
			t.timestamps
    end
    execute 'CREATE VIEW Gender ( Gender) AS SELECT gender FROM genders'
  end

  def self.down
    execute 'DROP VIEW Gender'
    drop_table :genders
  end
end
