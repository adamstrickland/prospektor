class AddApplicantRefToEmployees < ActiveRecord::Migration
  def self.up
    add_column :employees, :applicant_id, :integer
  end

  def self.down
    remove_column :employees, :applicant_id
  end
end
