class CreateCallBackStatuses < ActiveRecord::Migration
  def self.up
    CallBackStatus.new(:code => 'CP', :description => 'Completed Callback', :state => 'assigned').save
    CallBackStatus.new(:code => 'ST', :description => 'Stale Callback', :state => 'assigned').save
    CallBackStatus.new(:code => 'UN', :description => 'Uncalled Callback', :state => 'assigned').save
  end

  def self.down
    CallBackStatus.delete_all
  end
end
