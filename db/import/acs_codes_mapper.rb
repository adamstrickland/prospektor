class AcsCodesMapper < Pipeline::TransformMapper
  define_mappings({
    "ACSCodeID" => { :to => :id },
    "ACS Code" => { :to => :code },
    "ACS Code Description" => { :to => :description }
  })
end