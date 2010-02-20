class CollectionsMapper < Pipeline::TransformMapper
  define_mappings({
    'Job Collections ID' => { :to => :job_collections_id},
    'Job Invoice ID' => { :to => :job_invoice_id},
    'Date Received' => { :to => :date_received},
    'Amount' => { :to => :amount},
    'Date Posted' => { :to => :date_posted},
    'Department' => { :to => :department},
    'Comment' => { :to => :comment},
    'Job .' => { :to => :job_.},
    'MCS Hours Collected' => { :to => :mcs_hours_collected},
    'Adjustment' => { :to => :adjustment},
  })
end