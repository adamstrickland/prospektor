class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :lead
end
