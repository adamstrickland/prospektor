class StatesMapper < Pipeline::TransformMapper
  define_mappings({
    'State' => { :to => :state},'State Name' => { :to => :state_name}
  })
end
