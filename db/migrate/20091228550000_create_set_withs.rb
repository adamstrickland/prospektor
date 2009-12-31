class CreateSetWiths < ActiveRecord::Migration
  def self.up
    create_table :set_withs do |t|
      t.string :set_with
      t.timestamps
    end
    execute 'CREATE VIEW `Set With` ( `Set With`) AS SELECT set_with FROM set_withs'
  end
  def self.down
    execute 'DROP VIEW `Set With`'
    drop_table :set_withs
  end
end