class UpdateEventsForSti < ActiveRecord::Migration
  def self.up
    Event.all.each do |e|
      if e.user.present?
        if e.
      else
      end
    end
  end

  def self.down
  end
end
