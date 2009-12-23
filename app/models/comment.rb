class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :lead
  
  after_create :generate_event
  
  protected 
  
  def generate_event
    e = Event.new
    e.lead = self.lead
    e.user = self.user
    e.qualifier = self.comment
    e.action = 'comment'
    e.params = { :comment_id => self.id }
    e
  end
end
