class Prior WhatsMapper < Pipeline::TransformMapper
  define_mappings({
    'ID' => { :to => :id},'PriorWhat' => { :to => :prior_what}
  })
end
