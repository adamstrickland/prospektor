class PaysMapper < Pipeline::TransformMapper
  define_mappings({
    'PayID' => { :to => :id},
    'Date' => { :to => :date},
    'BCID' => { :to => :bcid},
    'Hours' => { :to => :hours},
    'Pay' => { :to => :pay},
  })
end