class AddTopicNumberToTopics < ActiveRecord::Migration
  def self.up
    add_column :topics, :number, :integer
  end

  def self.down
    remove_column :topics, :number
  end
end
