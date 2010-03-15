class AddStatusToCallBacks < ActiveRecord::Migration
  def self.up
    un = CallBackStatus.find_by_code('UN')
    unless un.present?
      un = CallBackStatus.new(:code => 'UN', :description => 'Uncalled Callback', :state => 'assigned').save
    end
    
    add_column :call_backs, :status_id, :integer, :default => un.id, :null => false
  end

  def self.down
    remove_column :call_backs, :status_id
  end
end
