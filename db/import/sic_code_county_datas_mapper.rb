class Sic Code County DatasMapper < Pipeline::TransformMapper
  define_mappings({
    'SIC Code' => { :to => :sic_code},'State' => { :to => :state},'County' => { :to => :county},'CountOfLeadID' => { :to => :count_of_lead_id},'CountOfCounty' => { :to => :count_of_county},'SumOfCountOfLeadID' => { :to => :sum_of_count_of_lead_id},'TEmp2' => { :to => :t_emp2},'TEmp3' => { :to => :t_emp3},'TEmp4' => { :to => :t_emp4},'TEmp5' => { :to => :t_emp5},'TEmp6' => { :to => :t_emp6},'TEmp7' => { :to => :t_emp7},'Temp8' => { :to => :temp8},'TVol3' => { :to => :t_vol3},'TVol4' => { :to => :t_vol4},'TVol5' => { :to => :t_vol5},'TVol6' => { :to => :t_vol6},'TVol7' => { :to => :t_vol7},'TVol8' => { :to => :t_vol8},'TCreditE' => { :to => :t_credit_e},'TCreditVG' => { :to => :t_credit_vg},'TCreditG' => { :to => :t_credit_g},'SSMA_TimeStamp' => { :to => :created_at}
  })
end
