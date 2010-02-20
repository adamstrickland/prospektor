class DbFailureRatesMapper < Pipeline::TransformMapper
  define_mappings({
    'SIC Division' => { :to => :sic_division},
    'SIC Division Description' => { :to => :sic_division_description},
    '0-1 Years' => { :to => :year_1},
    '2 Years' => { :to => :year_2},
    '3 Years' => { :to => :year_3},
    '4 Years' => { :to => :year_4},
    '5 Years' => { :to => :year_5},
    '6 Years' => { :to => :year_6},
    '7 Years' => { :to => :year_7},
    '8 Years' => { :to => :year_8},
    '9 Years' => { :to => :year_9},
    '10 Years' => { :to => :year_10},
  })
end