class Prior ConsultingsMapper < Pipeline::TransformMapper
  define_mappings({
    'ID' => { :to => :id},'Bad Experience' => { :to => :bad_experience}
  })
end
