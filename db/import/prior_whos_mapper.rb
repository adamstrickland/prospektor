class PriorWhosMapper < Pipeline::TransformMapper
  define_mappings({
    'ID' => { :to => :id},
    'PriorWho' => { :to => :prior_who},
  })
end