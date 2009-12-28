class JobsMapper < Pipeline::TransformMapper
  define_mappings({
    'Job Invoice ID' => { :to => :job_invoice_id},'Job .' => { :to => :job_.},'Employee ID' => { :to => :employee_id},'Invoice Date' => { :to => :invoice_date},'Amount' => { :to => :amount},'Expenses' => { :to => :expenses},'Prepaid' => { :to => :prepaid},'MCS Hours Billed' => { :to => :mcs_hours_billed},'Billing Rate' => { :to => :billing_rate},'Comment' => { :to => :comment},'PD' => { :to => :pd},'SSMA_TimeStamp' => { :to => :created_at}
  })
end
