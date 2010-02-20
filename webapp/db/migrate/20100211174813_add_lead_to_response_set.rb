class AddLeadToResponseSet < ActiveRecord::Migration
  def self.up
    add_column :response_sets, :lead_id, :integer
    add_index :response_sets, :lead_id
  end

  def self.down
    remove_column :response_sets, :lead_id
    
  end
end
