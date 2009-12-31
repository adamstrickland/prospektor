class AddFirstTimeFlagToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_time, :boolean, :default => true
  end

  def self.down
    remove_column :users, :first_time
  end
end
