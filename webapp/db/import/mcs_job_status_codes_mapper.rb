class McsJobStatusCodesMapper < Pipeline::TransformMapper
  define_mappings({
    'MCSJob StatusCodeID' => { :to => :mcs_job_status_code_id},
    'MCS Job Status' => { :to => :mcs_job_status},
  })
end