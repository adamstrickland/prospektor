class Mcs CodesMapper < Pipeline::TransformMapper
  define_mappings({
    'MCSCodeID' => { :to => :mcs_code_id},'MCS Code' => { :to => :mcs_code},'MCS Code Description' => { :to => :mcs_code_description}
  })
end
