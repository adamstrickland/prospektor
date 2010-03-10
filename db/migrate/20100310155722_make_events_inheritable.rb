class MakeEventsInheritable < ActiveRecord::Migration
  def self.up
    add_column :events, :type, :string
    rename_column :events, :qualifier, :message
    change_column :events, :message, :length => 2000
    rename_column :events, :params, :data
    change_column :events, :data, :text
  end

  def self.down
    remove_column :events, :type, :string
    rename_column :events, :message, :qualifier
    change_column :events, :data, :string
    rename_column :events, :data, :params
  end
end
