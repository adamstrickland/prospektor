class AddMethodToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :on_complete_callback_method, :string, :default => 'post'
    rename_column :videos, :on_complete_hook, :on_complete_callback_template
    rename_column :videos, :url, :url_template
  end

  def self.down
    remove_column :videos, :on_complete_callback_method
    rename_column :videos, :on_complete_callback_template, :on_complete_hook
    rename_column :videos, :url_template, :url
  end
end
