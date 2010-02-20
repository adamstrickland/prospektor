class TimeZone < ActiveRecord::Base
  has_many :states
  validates_presence_of :time_zone, :description
  validates_length_of :time_zone, :is => 1
  alias_attribute :abbrev, :time_zone
  alias_attribute :abbreviation, :abbrev
  
  def name
    self.description.split(' ')[0].capitalize
  end
end
