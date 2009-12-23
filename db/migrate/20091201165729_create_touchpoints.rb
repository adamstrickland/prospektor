class CreateTouchpoints < ActiveRecord::Migration
  def self.up
    create_table :touchpoints do |t|
      t.references :call_queue, :null => false
      t.references :lead, :null => false
      t.integer :position
      t.timestamps
      
      t.index [:call_queue_id, :lead_id], :unique => true
      t.index :call_queue_id
    end
    
    Touchpoint.reset_column_information
    
    CallQueue.find(:all) do |cq|
      position = 0
      if cq.respond_to?('leads')
        cq.leads.each do |l|
          tp = Touchpoint.new
          tp.call_queue = cq
          tp.lead = l
          # tp.user = cq.user
          tp.position = position
          position += 1
          tp.save
        end
      end
    end
  end

  def self.down
    CallQueue.find(:all) do |cq|
      if cq.respond_to?('touchpoints')
        cq.leads = cq.touchpoints.map{|tp| tp.lead}
        cq.save
      end
    end
    
    drop_table :touchpoints
  end
end
