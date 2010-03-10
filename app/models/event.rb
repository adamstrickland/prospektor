class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :lead
  
  validates_presence_of :action
  
  def message
    "#{self.action} #{self.qualifier}"
  end
  
  # params accessors for legacy stuff
  def params
    self.data
  end
  
  def params=(val)
    self.data = val
  end
end
