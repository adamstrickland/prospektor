require File.join(Rails.root, 'lib', 'active_record', 'acts', 'enhanced_list')

class Touchpoint < ActiveRecord::Base
  include ActiveRecord::Acts::EnhancedList
  
  belongs_to :lead
  belongs_to :call_queue
  acts_as_list :scope => :call_queue
  
  def available_at
    self.call_window_start_at || self.call_queue.queue_date.to_datetime
  end
  
  def available?
    now = Time.now
    self.available_at <= now and ((not self.call_window_finish_at) or now <= self.call_window_finish_at)
  end
  
  def next
    begin
      callbacks = self.call_queue.user.callbacks.reject{|l| l.id == self.lead.id}
      if callbacks and callbacks.count > 0
        callback = callbacks.first
        touchpoint = self.call_queue.touchpoints.detect{|tp| tp.lead == callback}
        if not touchpoint
          touchpoint = Touchpoint.new
          touchpoint.call_queue = self.call_queue
          touchpoint.lead = callback
          touchpoint.save!
        end
        
        if touchpoint != self.lower_item
          touchpoint.insert_at(self.lower_item.position)
        end
      end
    rescue
      logger.error "a problem pulling up a callback ocurred"
    ensure
      return self.lower_item
    end
  end
  
  def prev
    self.higher_item
  end
end
