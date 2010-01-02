class Presentation < ActiveRecord::Base
  belongs_to :lead
  belongs_to :user
  
  after_save do |rec|
    Event.new(
      :lead => rec.lead,
      :user => rec.user,
      :qualifier => 'BCR Video',
      :action => 'invited',
      :params => { :to => rec.email }.to_yaml
    ).save
  end
  
  validates_presence_of :email, :url, :user, :lead
  validates_email :email
end
