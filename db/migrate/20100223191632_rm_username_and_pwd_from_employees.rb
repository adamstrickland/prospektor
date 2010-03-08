class RmUsernameAndPwdFromEmployees < ActiveRecord::Migration
  def self.up
    remove_column :employees, :username
    remove_column :employees, :password
  end

  def self.down
  end
end
