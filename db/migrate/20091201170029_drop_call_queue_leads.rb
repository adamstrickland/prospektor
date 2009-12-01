class DropCallQueueLeads < ActiveRecord::Migration
  def self.up
    drop_table :call_queues_leads
  end

  def self.down  
    create_table :call_queues_leads, :id => false do |t|
      t.references :call_queue, :null => false
      t.references :lead, :null => false
      t.index [:call_queue_id, :lead_id], :unique => true
    end
  end
end
