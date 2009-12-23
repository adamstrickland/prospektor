class Presentation < ActiveRecord::Base
  belongs_to :lead
  belongs_to :user
  
  after_create :generate_event
  
  validates_presence_of :email, :url, :user, :lead
  validates_email :email
  
  # def self.initialize(params=[])
  #   super(params)
  #   url = Presentation.generate_url
  # end
  
  # def as_history
  #   {
  #     :type => 'presentation',
  #     :touched_at => self.created_at,
  #     :touchpoint => self.email
  #   }
  # end
  protected
  
  def generate_event
    e = Event.new
    e.lead = self.lead
    e.user = self.user
    e.qualifier = self.class.to_s
    e.action = 'invited'
    e.params = { :to => self.email }.to_yaml
    e
  end
end
