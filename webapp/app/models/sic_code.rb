class SicCode < ActiveRecord::Base
  alias_attribute :code, :sic_code
  alias_attribute :division, :sic_division
  alias_attribute :name, :description
  alias_attribute :employee_code, :emp
  alias_attribute :volume_code, :vol
  
  # alias_method :find_by_code, :find_by_sic_code
  # alias_method :find_by_division, :find_by_sic_division
  # alias_method :find_all_by_division, :find_al_by_sic_division
  
  def self.find_by_code(*args)
    self.find_by_sic_code(*args)
  end
  
  def self.find_by_division(*args)
    self.find_by_sic_division(*args)
  end
  
  def self.find_all_by_division(*args)
    self.find_all_by_sic_division(*args)
  end
  
  def self.acceptable
    self.find_all_by_acceptable('Yes')
  end
  
  def is_acceptable?
    ['yes','true',1,'y','t'].include?(self.acceptable.downcase)
  end
  
  def is_acceptable=(val)
    self.acceptable = val ? 'Yes' : 'No'
  end
end
