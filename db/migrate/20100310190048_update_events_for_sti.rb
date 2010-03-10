class UpdateEventsForSti < ActiveRecord::Migration
  def self.up
    Event.all.each do |e|
      if e.lead.present?
        e.type = 'LeadEvent'
      else
        if e.user.present?
          e.type = 'UserEvent'
        else
          e.type = 'SystemEvent'
        end
      end
      e.save
    end
  end

  def self.down
  end
end
