class AddCallbackToPresentation < ActiveRecord::Migration
  def self.up
    add_column :presentations, :callback_date, :date, :null => false, :default => Date.today
    add_column :presentations, :callback_time, :time, :null => false, :default => 1.hours.from_now
  end

  def self.down
    remove_column :presentations, :callback_date
    remove_column :presentations, :callback_time
  end
end
