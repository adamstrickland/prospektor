class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :lead
  
  after_save do |rec| 
    LeadEvent.commented(rec.lead, current_user || rec.user)
  end
end
