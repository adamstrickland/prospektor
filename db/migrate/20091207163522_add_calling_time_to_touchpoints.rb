class AddCallingTimeToTouchpoints < ActiveRecord::Migration
  def self.up
    alter_table :touchpoints do |t|
      t.datetime :call_window_start_at
      t.datetime :call_window_finish_at
    end
  end

  def self.down
    remove_column :touchpoints, :call_window_start_at
    remove_column :touchpoints, :call_window_finish_at
  end
end
