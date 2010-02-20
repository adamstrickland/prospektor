class SicCodesMapper < Pipeline::TransformMapper
  define_mappings({
    'SIC Division' => { :to => :sic_division},
    'SIC Code' => { :to => :sic_code},
    'Description' => { :to => :description},
    'Acceptable' => { :to => :acceptable},
    'Emp' => { :to => :emp},
    'Vol' => { :to => :vol},
  })
end