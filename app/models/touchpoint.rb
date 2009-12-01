class Touchpoint < ActiveRecord::Base
  belongs_to :lead
  belongs_to :call_queue
  acts_as_list :scope => :call_queue
  
  attr_accessor :next_id
end
