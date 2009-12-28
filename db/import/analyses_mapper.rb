class AnalysesMapper < Pipeline::TransformMapper
  define_mappings({
    'ID' => { :to => :id},
    'Job .' => { :to => :job_.},
    'Analyst' => { :to => :analyst},
    'ACS Status' => { :to => :acs_status},
    'MCS Status' => { :to => :mcs_status},
    'Job Status' => { :to => :job_status},
    'Ran' => { :to => :ran},
    'Hours Sold' => { :to => :hours_sold},
    'Project' => { :to => :project},
    'Men' => { :to => :men},
    'MCS Date' => { :to => :mcs_date},
    'MCS Time' => { :to => :mcs_time},
    'Comment' => { :to => :comment},
    'PayRate' => { :to => :pay_rate},
    'LCRP-Email' => { :to => :lcrp_email},
  })
end