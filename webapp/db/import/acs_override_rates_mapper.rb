class AcsOverrideRatesMapper < Pipeline::TransformMapper
  define_mappings({
    'ACSOverrideRateID' => { :to => :acs_override_rate_id},
    'ACS EmpID' => { :to => :acs_emp_id},
    'ACS Emp OverrideRate' => { :to => :acs_emp_override_rate},
    'Comment' => { :to => :comment},
  })
end