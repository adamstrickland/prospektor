class MakeEventsInheritable < ActiveRecord::Migration
  def self.up
    add_column :events, :type, :string
    change_column :events, :qualifier, :string, :length => 2000
    rename_column :events, :params, :data
    change_column :events, :data, :text
  end

  def self.down
    change_column :events, :data, :string
    rename_column :events, :data, :params
    remove_column :events, :type
  end
end
