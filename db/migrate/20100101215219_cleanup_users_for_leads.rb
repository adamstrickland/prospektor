class CleanupUsersForLeads < ActiveRecord::Migration
  def self.up
    remove_column :leads, :user_id
  end

  def self.down
    add_column :leads, :user_id, :integer
  end
end
