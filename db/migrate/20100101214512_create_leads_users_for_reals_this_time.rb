class CreateLeadsUsersForRealsThisTime < ActiveRecord::Migration
  def self.up
    create_table :leads_users, :id => false do |t|
      t.integer :lead_id, :null => false
      t.integer :user_id, :null => false
      t.string :context
      t.timestamps
      t.index [:lead_id, :user_id]
      t.index :created_at
      t.index :lead_id
      t.index :user_id
    end
  end

  def self.down
    drop_table :leads_users
  end
end
