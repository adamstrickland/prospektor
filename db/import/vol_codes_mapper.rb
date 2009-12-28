class Vol CodesMapper < Pipeline::TransformMapper
  define_mappings({
    'Vol Code' => { :to => :vol_code},'Sales Volume' => { :to => :sales_volume},'RefUSA Sales Volume' => { :to => :ref_usa_sales_volume},'SSMA_TimeStamp' => { :to => :created_at}
  })
end
