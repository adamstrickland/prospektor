class AddVoipToApplicant < ActiveRecord::Migration
  def self.up
    add_column :applicants, :has_voip, :boolean, :default => false
  end

  def self.down
    remove_column :applicants, :has_voip
  end
end
