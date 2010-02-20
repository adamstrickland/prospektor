class ZipCodesMapper < Pipeline::TransformMapper
  define_mappings({
    'ID' => { :to => :id},
    'Zip' => { :to => :zip},
    'City' => { :to => :city},
    'State' => { :to => :state},
    'County' => { :to => :county},
    'Area Code' => { :to => :area_code},
    'Time Zone' => { :to => :time_zone},
  })
end