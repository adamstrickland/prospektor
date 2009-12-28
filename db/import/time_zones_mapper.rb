class TimeZonesMapper < Pipeline::TransformMapper
  define_mappings({
    'Time Zone' => { :to => :time_zone},
    'Description' => { :to => :description},
  })
end