class CreatePays < ActiveRecord::Migration
  def self.up
    create_table :pays do |t|
      t.integer :id
      t.datetime :date
      t.integer :bcid
      t.string :hours
      t.string :pay
      t.timestamps
    end
    execute 'CREATE VIEW `Pay` ( `PayID`,`Date`,`BCID`,`Hours`,`Pay`) AS SELECT id,date,bcid,hours,pay FROM pays'
  end
  def self.down
    execute 'DROP VIEW `Pay`'
    drop_table :pays
  end
end