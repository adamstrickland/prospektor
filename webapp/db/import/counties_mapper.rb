class CountiesMapper < Pipeline::TransformMapper
  define_mappings({
    'ID' => { :to => :id},
    'State' => { :to => :state},
    'County' => { :to => :county},
    'Population' => { :to => :population},
    'Area' => { :to => :area},
    '2008' => { :to => :year_2008},
    '2007' => { :to => :year_2007},
    '2006' => { :to => :year_2006},
    '2005' => { :to => :year_2005},
    '2004' => { :to => :year_2004},
    '2003' => { :to => :year_2003},
    '2002' => { :to => :year_2002},
    '2001' => { :to => :year_2001},
    '2000' => { :to => :year_2000},
    'Time Zone' => { :to => :time_zone},
    'Daylight Savings' => { :to => :daylight_savings},
    'EmpID' => { :to => :emp_id},
    'Date Issued' => { :to => :date_issued},
  })
end