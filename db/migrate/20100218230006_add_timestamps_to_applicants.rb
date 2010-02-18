class AddTimestampsToApplicants < ActiveRecord::Migration
  def self.up
    add_timestamps :applicants
  end

  def self.down
    remove_timestamps :applicants
  end
end
