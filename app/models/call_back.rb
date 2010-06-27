class CallBack < ActiveRecord::Base
  belongs_to :user
  belongs_to :lead
  belongs_to :status, :class_name => 'CallBackStatus'
  
  validates_presence_of :callback_at, :user, :lead, :status
  
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
      {
        :conditions => ['callback_at >= ? and callback_at <= ?', from || Date.today, to],
        :order => 'callback_at ASC, call_backs.created_at ASC'
      }
    },
    :negative => false
  
  named_scope :future, 
    :conditions => ['callback_at >= ?', Time.now], 
    :order => 'callback_at ASC, call_backs.created_at ASC', 
    :negative => false
  
  named_scope :uncalled, 
    :include => :status,
    :conditions => "statuses.code = 'UN'",
    :negative => false
  # named_scope :uncalled, 
  #   :include => :lead,
  #   :conditions => 'leads.updated_at <= call_backs.updated_at',
  #   # :order => 'callback_at ASC, callbacks.created_at ASC',
  #   :negative => false
  
  def complete!
    self.status = CallBackStatus.complete
    self.save
  end
end