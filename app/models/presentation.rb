class Presentation < ActiveRecord::Base
  belongs_to :lead
  belongs_to :user
  belongs_to :topic
  
  after_save do |rec|
    LeadEvent.sent(rec.lead, rec.topic.name, rec.user, { :to => rec.email })
  end
  
  validates_presence_of :email, :url, :user, :lead, :topic
  validates_email :email
end
