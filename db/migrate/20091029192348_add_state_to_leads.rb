class AddStateToLeads < ActiveRecord::Migration
  def self.up
    add_column :leads, :aasm_state, :string
  end

  def self.down
    remove_column :leads, :aasm_state
  end
end
