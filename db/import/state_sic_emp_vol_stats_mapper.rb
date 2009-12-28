class State Sic Emp Vol StatsMapper < Pipeline::TransformMapper
  define_mappings({
    'State' => { :to => :state},'SIC Code' => { :to => :sic_code},'EmpU' => { :to => :emp_u},'Emp1' => { :to => :emp1},'Emp2' => { :to => :emp2},'Emp3' => { :to => :emp3},'Emp4' => { :to => :emp4},'Emp5' => { :to => :emp5},'Emp6' => { :to => :emp6},'Emp7' => { :to => :emp7},'Emp8' => { :to => :emp8},'VolU' => { :to => :vol_u},'Vol1' => { :to => :vol1},'Vol2' => { :to => :vol2},'Vol3' => { :to => :vol3},'Vol4' => { :to => :vol4},'Vol5' => { :to => :vol5},'Vol6' => { :to => :vol6},'Vol7' => { :to => :vol7},'Vol8' => { :to => :vol8},'Updated' => { :to => :updated}
  })
end
