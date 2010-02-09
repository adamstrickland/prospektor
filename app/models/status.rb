class Status < ActiveRecord::Base
  has_many :leads
  named_scope :for_leads, :conditions => {:context => 'Lead'}
end
