class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :name, :null => false
      t.boolean :complimentary, :null => false, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
