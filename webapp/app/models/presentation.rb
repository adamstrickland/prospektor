class Presentation < ActiveRecord::Base
  belongs_to :lead
  belongs_to :user
  belongs_to :topic
  
  after_save do |rec|
    Event.new(
      :lead => rec.lead,
      :user => rec.user,
      :qualifier => rec.topic ? rec.topic.name : 'BCR',
      :action => 'invited',
      :params => { :to => rec.email }.to_yaml
    ).save
  end
  
  validates_presence_of :email, :url, :user, :lead, :topic
  validates_email :email
end
