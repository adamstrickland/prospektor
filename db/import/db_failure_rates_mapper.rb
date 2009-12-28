class Db Failure RatesMapper < Pipeline::TransformMapper
  define_mappings({
    'SIC Division' => { :to => :sic_division},'SIC Division Description' => { :to => :sic_division_description},'0-1 Years' => { :to => :0_1_years},'2 Years' => { :to => :2_years},'3 Years' => { :to => :3_years},'4 Years' => { :to => :4_years},'5 Years' => { :to => :5_years},'6 Years' => { :to => :6_years},'7 Years' => { :to => :7_years},'8 Years' => { :to => :8_years},'9 Years' => { :to => :9_years},'10 Years' => { :to => :10_years},'SSMA_TimeStamp' => { :to => :created_at}
  })
end
