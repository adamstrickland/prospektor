class AddEmployeeIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :employee_id, :integer
  end

  def self.down
    remove_column :users, :employee_id
  end
end
