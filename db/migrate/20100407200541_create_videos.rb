class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :name, :null => false
      t.string :url, :null => false
      t.string :on_complete_hook
      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
