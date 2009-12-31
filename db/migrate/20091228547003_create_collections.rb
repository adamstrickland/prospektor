class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |t|
      t.integer :job_collections_id
      t.integer :job_invoice_id
      t.datetime :date_received
      t.float :amount
      t.datetime :date_posted
      t.string :department
      t.string :comment
      t.string :job
      t.string :mcs_hours_collected
      t.string :adjustment
      t.timestamps
    end
    execute 'CREATE VIEW `CollectionsView` ( `Job Collections ID`,`Job Invoice ID`,`Date Received`,`Amount`,`Date Posted`,`Department`,`Comment`,`Job .`,`MCS Hours Collected`,`Adjustment`) AS SELECT job_collections_id,job_invoice_id,date_received,amount,date_posted,department,comment,job,mcs_hours_collected,adjustment FROM collections'
  end
  def self.down
    execute 'DROP VIEW `CollectionsView`'
    drop_table :collections
  end
end