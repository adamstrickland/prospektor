class AddTypeToTopic < ActiveRecord::Migration
  def self.up
    add_column :topics, :type, :string
    add_column :topics, :information, :string
    add_index :topics, :type
  end

  def self.down
    remove_column :topics, :type
    remove_column :topics, :information
  end
end
