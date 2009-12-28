class CountiesMapper < Pipeline::TransformMapper
  define_mappings({
    'ID' => { :to => :id},
    'State' => { :to => :state},
    'County' => { :to => :county},
    'Population' => { :to => :population},
    'Area' => { :to => :area},
    '2008' => { :to => :2008},
    '2007' => { :to => :2007},
    '2006' => { :to => :2006},
    '2005' => { :to => :2005},
    '2004' => { :to => :2004},
    '2003' => { :to => :2003},
    '2002' => { :to => :2002},
    '2001' => { :to => :2001},
    '2000' => { :to => :2000},
    'Time Zone' => { :to => :time_zone},
    'Daylight Savings' => { :to => :daylight_savings},
    'EmpID' => { :to => :emp_id},
    'Date Issued' => { :to => :date_issued},
  })
end