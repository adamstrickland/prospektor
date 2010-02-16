class State < ActiveRecord::Base
  belongs_to :time_zone
  validates_presence_of :time_zone, :state, :state_name
  validates_length_of :state, :is => 2
  alias_attribute :abbrev, :state
  alias_attribute :abbreviation, :abbrev
  alias_attribute :name, :state_name
end
