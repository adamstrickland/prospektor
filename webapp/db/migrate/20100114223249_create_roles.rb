class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :title, :null => false
      t.timestamps
      t.index :title, :unique => true
    end
    create_table :roles_users, :id => false do |t|
      t.references :role, :null => false
      t.references :user, :null => false
      t.index [:user_id, :role_id], :unique => true
      t.index :user_id
      t.index :role_id
    end
  end

  def self.down
    drop_table :roles_users
    drop_table :roles
  end
end
