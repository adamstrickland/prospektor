class DropApplicantDispoStatus < ActiveRecord::Migration
  def self.up
    drop_table :applicant_disposition_status
  end

  def self.down
  end
end
