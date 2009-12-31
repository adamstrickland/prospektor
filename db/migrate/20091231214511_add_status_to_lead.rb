class AddStatusToLead < ActiveRecord::Migration
  def self.up
    add_column :leads, :status_id, :integer
  end

  def self.down
    remove_column :leads, :status_id
  end
end
