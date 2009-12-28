class CreateExpenseReimbursements < ActiveRecord::Migration
  def self.up
    create_table :expense_reimbursements do |t|
      t.integer :expense_id
      t.string :period_ending
      t.string :expense_reimbursement
      t.integer :emp_id
      t.string :jobs
      t.timestamps
    end
    execute 'CREATE VIEW `Expense Reimbursement` ( `Expense ID`,`Period Ending`,`Expense Reimbursement`,`EmpID`,`Jobs`) AS SELECT expense_id,period_ending,expense_reimbursement,emp_id,jobs FROM expense_reimbursements'
  end
  def self.down
    execute 'DROP VIEW `Expense Reimbursement`'
    drop_table :expense_reimbursements
  end
end