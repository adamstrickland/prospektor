class CreateLeadsUsers < ActiveRecord::Migration
  def self.up
    # create_table :leads_users, :id => false do |t|
    #   t.references :lead, :null => false
    #   t.references :user, :null => false
    #   t.timestamps
    # end
    # add_index(:leads_users, [:lead_id, :user_id], :unique => false)
    alter_table :leads do |t|
      t.references :user
      t.index :user_id, :unique => false
    end
    
  end

  def self.down
    # remove_table :leads_users
    remove_column :leads, :user_id
  end
end
