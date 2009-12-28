class AddCallingTimeToTouchpoints < ActiveRecord::Migration
  def self.up
    add_column :touchpoints, :call_window_start_at, :datetime
    add_column :touchpoints, :call_window_finish_at, :datetime
  end

  def self.down
    remove_column :touchpoints, :call_window_start_at
    remove_column :touchpoints, :call_window_finish_at
  end
end
