class CreateCallbacks < ActiveRecord::Migration
  def self.up
    create_table :call_backs do |t|
      t.references :user, :null => false
      t.datetime :callback_at, :null => false
      t.references :lead
      t.timestamps
    end
    
    # add_index :callbacks, [:user_id, :lead_id], :unique => true
    add_index :call_backs, [:user_id, :lead_id]
    add_index :call_backs, :user_id
    add_index :call_backs, :lead_id
    add_index :call_backs, :callback_at
    add_index :call_backs, [:user_id, :callback_at]
  end

  def self.down
    drop_table :call_backs
  end
end
