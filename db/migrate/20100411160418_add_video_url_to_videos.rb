class AddVideoUrlToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :video_url_template, :string, :null => false
  end

  def self.down
    remove_column :videos, :video_url_template
  end
end
