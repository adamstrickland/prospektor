class AcsCompensationPlanMapper < Pipeline::TransformMapper
  define_mappings({
    "ACSCompID" => { :to => :id },
    "MCS Override" => { :to => :mcs_override },
    "GO Rate" => { :to => :go_rate },
    "JBA" => { :to => :jba },
    "SSMA_TimeStamp" => { :to => :created_at }
  })
end