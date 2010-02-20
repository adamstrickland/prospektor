class AddNdaAcceptedToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :nda_accepted, :boolean, :default => false
    
    
    
  end

  def self.down
    remove_column :users, :nda_accepted
  end
end
