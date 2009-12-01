class CallQueue < ActiveRecord::Base
  belongs_to :user
  # has_and_belongs_to_many :leads
  has_many :leads, :through => :touchpoints
  has_many :touchpoints, :order => 'position'
  
  named_scope :by_owner, lambda{ |user|
    {
      :conditions => { :user_id => user }
    }
  }
  
  def next_in_queue(for_lead)
    current_index = self.leads.index(for_lead)
    next_index = (current_index + 1 == self.leads.count ? 0 : current_index + 1)
    self.leads[next_index]
  end
end
