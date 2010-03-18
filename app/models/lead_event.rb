class LeadEvent < Event
  validates_presence_of :lead
  
  def self.sent(lead, subj, user=current_user, params=nil)
    data = if params.present?
      (params.respond_to?(:to_yaml) ? params.to_yaml : params)
    else
      nil
    end
    LeadEvent.new(:lead => lead, :user => user, :qualifier => subj, :action => 'sent', :data => data).save
  end
  
  def self.comment(lead, user=current_user)
    self.new(:lead => lead, :user => user, :action => 'commented').save
  end
  
  def self.set_appointment(lead, at, user=current_user)
    self.new(:lead => lead, :user => user, :action => 'set', :qualifier => "appointment for #{at.to_s}").save
  end
end