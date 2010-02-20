class TitleCodesMapper < Pipeline::TransformMapper
  define_mappings({
    'Title Code' => { :to => :title_code},
    'Title' => { :to => :title},
  })
end