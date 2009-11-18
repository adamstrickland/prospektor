class CreateCallQueues < ActiveRecord::Migration
  def self.up
    create_table :call_queues do |t|
      t.string :name, :null => false
      t.date :queue_date, :null => false
      t.references :user, :null => false

      t.timestamps
    end
    
    create_table :call_queues_leads, :id => false do |t|
      t.references :call_queue, :null => false
      t.references :lead, :null => false
      t.index [:call_queue_id, :lead_id], :unique => true
    end
  end

  def self.down
    drop_table :call_queues
    drop_table :call_queues_leads
  end
end
