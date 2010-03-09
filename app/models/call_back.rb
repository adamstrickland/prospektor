class CallBack < ActiveRecord::Base
  belongs_to :user
  belongs_to :lead
  
  named_scope :stale,
    :joins => 'INNER JOIN leads L ON (call_backs.lead_id = L.id) LEFT OUTER JOIN statuses T ON (L.status_id = T.id)',
    :conditions => ["callback_at < ? AND (
      L.status_id IS NULL OR
      (L.status_id IS NOT NULL AND T.code IN ('CB'))
    )", Time.now],
    :negative => false
    
  named_scope :window, 
    lambda { |to, *optional|
      from, *ignored = *optional
      from ||= Date.today
      {
        :conditions => ['callback_at >= ? and callback_at <= ?', from, to]
      }
    },
    :negative => false
end
