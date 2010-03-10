class UserEvent < Event
  validates_presence_of :user
  
  def self.login_success(user=current_user)
    self.new(:user => user, :action => 'login', :qualifer => 'success').save
  end

  def self.login_failed(user=current_user)
    self.new(:user => user, :action => 'login', :qualifer => 'failed').save
  end
  
  def self.logout(user=current_user)
    self.new(:user => user, :action => 'logout').save
  end
  
  def self.acces_lead(lead, user=current_user)
    self.new(:user => user, :action => 'access', :lead => lead).save
  end
end