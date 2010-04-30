class LeadEvent < Event
  validates_presence_of :lead
  
  def self.sent(lead, subj, user=current_user, params=nil)
    data = if params.present?
      (params.respond_to?(:to_yaml) ? params.to_yaml : params)
    else
      nil
    end
    self.make_event(lead, user, {:qualifier => subj, :action => 'sent', :data => data})
  end
  
  def self.comment(lead, user=current_user)
    self.make_event(lead, user, {:action => 'commented'})
  end
  
  def self.set_appointment(lead, at, user=current_user)
    self.make_event(lead, user, {:action => 'set', :qualifier => "appointment for #{at.to_s}"})
  end
  
  def self.opened_video(lead, user, video)
    self.make_event(lead, user, {:action => 'opened', :qualifier => "video: #{video.name}"})
  end
  
  def self.video_callback(lead, user)
    self.make_event(lead, user, {:action => 'created', :qualifier => 'video callback'})
  end
  
  
  
  def self.make_event(lead, user, options)
    self.create({:lead => lead, :user => user}.merge(options))
  end
end