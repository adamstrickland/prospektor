class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :lead
  
  after_save do |rec| 
    Event.new(
      :lead => rec.lead, 
      :user => rec.user, 
      :qualifier => rec.comment, 
      :action => 'commented', 
      :params => { :comment_id => self.id }.to_yaml
    ).save 
  end
end
