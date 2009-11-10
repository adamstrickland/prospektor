class Presentation < ActiveRecord::Base
  belongs_to :lead
  belongs_to :user
  
  validates_presence_of :email, :url, :user, :lead
  validates_email :email
  
  # def self.initialize(params=[])
  #   super(params)
  #   url = Presentation.generate_url
  # end
  
  def as_history
    {
      :type => 'presentation',
      :touched_at => self.created_at,
      :touchpoint => self.email
    }
  end
end
