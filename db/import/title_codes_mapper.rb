class Title CodesMapper < Pipeline::TransformMapper
  define_mappings({
    'Title Code' => { :to => :title_code},'Title' => { :to => :title},'SSMA_TimeStamp' => { :to => :created_at}
  })
end
