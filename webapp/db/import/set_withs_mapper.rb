class SetWithsMapper < Pipeline::TransformMapper
  define_mappings({
    'Set With' => { :to => :set_with},
  })
end