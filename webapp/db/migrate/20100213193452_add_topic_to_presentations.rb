class AddTopicToPresentations < ActiveRecord::Migration
  def self.up
    add_column :presentations, :topic_id, :integer
    add_index :presentations, :topic_id
  end

  def self.down
    remove_column :presentations, :topic_id
  end
end
