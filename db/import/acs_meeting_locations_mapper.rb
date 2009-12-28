class AcsMeetingLocationsMapper < Pipeline::TransformMapper
  define_mappings({
    'ID' => { :to => :id},
    'Location' => { :to => :location},
  })
end