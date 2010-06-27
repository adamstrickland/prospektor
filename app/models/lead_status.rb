class LeadStatus < Status
  def self.callback
    self.find_by_code('CB')
  end
  
  def self.no_interest
    self.find_by_code('NI')
  end
  
  def self.skip
    self.find_by_code('SKIP')
  end
  
  def display
    case self.code
    when 'CB' then 'Callback for Sale'
    when 'FP' then 'Scheduled Call'
    when 'INV' then 'Video Callback'
    else self.code      
    end
  end
end