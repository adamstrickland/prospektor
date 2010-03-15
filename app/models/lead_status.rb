class LeadStatus < Status
  def self.callback
    self.find_by_code('CB')
  end
  
  def self.no_interest
    self.find_by_code('NI')
  end
end