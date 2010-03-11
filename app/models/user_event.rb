class UserEvent < Event
  validates_presence_of :user
  
  def self.login_success(user)
    self.new(:user => user, :action => 'login', :qualifer => 'success').save
  end

  def self.login_failed(user)
    self.new(:user => user, :action => 'login', :qualifer => 'failed').save
  end
  
  def self.logout(user)
    self.new(:user => user, :action => 'logout').save
  end
  
  def self.access_lead(lead, user)
    self.new(:user => user, :action => 'access', :lead => lead).save
  end
end