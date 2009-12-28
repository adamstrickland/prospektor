class GendersMapper < Pipeline::TransformMapper
  define_mappings({
    'Gender' => { :to => :gender}
  })
end
