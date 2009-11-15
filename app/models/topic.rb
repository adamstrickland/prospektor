class Topic < ActiveRecord::Base
  has_many :appointments
end
