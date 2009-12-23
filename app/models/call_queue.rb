class CallQueue < ActiveRecord::Base
  belongs_to :user
  # has_and_belongs_to_many :leads
  has_many :leads, :through => :touchpoints
  has_many :touchpoints, :order => 'position'
end
