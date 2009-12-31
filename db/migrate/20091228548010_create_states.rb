class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :state
      t.string :state_name
      t.timestamps
    end
    execute 'CREATE VIEW `StatesView` ( `State`,`State Name`) AS SELECT state,state_name FROM states'
  end
  def self.down
    execute 'DROP VIEW `StatesView`'
    drop_table :states
  end
end