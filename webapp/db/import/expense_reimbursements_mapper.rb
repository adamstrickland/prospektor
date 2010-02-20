class ExpenseReimbursementsMapper < Pipeline::TransformMapper
  define_mappings({
    'Expense ID' => { :to => :expense_id},
    'Period Ending' => { :to => :period_ending},
    'Expense Reimbursement' => { :to => :expense_reimbursement},
    'EmpID' => { :to => :emp_id},
    'Jobs' => { :to => :jobs},
  })
end