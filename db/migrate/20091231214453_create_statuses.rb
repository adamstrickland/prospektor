class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.string :code, :null => false
      t.string :description, :null => false
      t.string :state, :null => false
      t.string :context
      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
