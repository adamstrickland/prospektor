class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :lead
  
  after_save do |rec| 
    LeadEvent.comment(rec.lead, rec.user)
  end
end
