class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :job_invoice_id
      t.string :job
      t.integer :employee_id
      t.datetime :invoice_date
      t.float :amount
      t.string :expenses
      t.integer :prepaid
      t.string :mcs_hours_billed
      t.float :billing_rate
      t.string :comment
      t.string :pd
      t.timestamps
    end
    execute 'CREATE VIEW `JobsView` ( `Job Invoice ID`,`Job .`,`Employee ID`,`Invoice Date`,`Amount`,`Expenses`,`Prepaid`,`MCS Hours Billed`,`Billing Rate`,`Comment`,`PD`) AS SELECT job_invoice_id,job,employee_id,invoice_date,amount,expenses,prepaid,mcs_hours_billed,billing_rate,comment,pd FROM jobs'
  end
  def self.down
    execute 'DROP VIEW `JobsView`'
    drop_table :jobs
  end
end