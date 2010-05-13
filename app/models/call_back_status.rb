class CallBackStatus < Status
  def self.uncalled
    self.find_by_code('UN')
  end
  
  def self.complete
    self.find_by_code('CP')
  end
  
  def self.stale
    self.find_by_code('ST')
  end
end