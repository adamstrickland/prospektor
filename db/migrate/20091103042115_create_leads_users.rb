class CreateLeadsUsers < ActiveRecord::Migration
  def self.up
    create_table :leads_users, :id => false do |t|
      t.references :lead, :null => false
      t.references :user, :null => false
      t.timestamps
    end
    add_index(:leads_users, [:lead_id, :user_id], :unique => false)
  end

  def self.down
    remove_table :leads_users
  end
end
