class AddVideoTopic < ActiveRecord::Migration
  def self.up
    add_column :topics, :video_id, :integer
  end

  def self.down
    remove_column :topics, :video_id
  end
end
