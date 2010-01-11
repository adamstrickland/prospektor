class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :lead
  
  def message
    self.qualifier
  end
end
