class Employee < ActiveRecord::Base
  has_one :user
end
