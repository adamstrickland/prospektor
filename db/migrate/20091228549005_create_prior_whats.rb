class CreatePriorWhats < ActiveRecord::Migration
  def self.up
    create_table :prior_whats do |t|
      t.integer :id
      t.datetime :prior_what
      t.timestamps
    end
    execute 'CREATE VIEW `PriorWhat` ( `ID`,`PriorWhat`) AS SELECT id,prior_what FROM prior_whats'
  end
  def self.down
    execute 'DROP VIEW `PriorWhat`'
    drop_table :prior_whats
  end
end