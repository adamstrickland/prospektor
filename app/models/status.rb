class Status < ActiveRecord::Base
  has_many :status
  named_scope :for_leads, :conditions => {:context => 'Lead'}
end
