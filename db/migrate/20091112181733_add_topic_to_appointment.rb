class AddTopicToAppointment < ActiveRecord::Migration
  def self.up
    add_column :appointments, :topic_id, :integer, :default => 1
    remove_column :appointments, :subject
  end

  def self.down
    remove_column :appointments, :topic_id
    add_column :appointments, :subject, :string
  end
end
