class Project CodesMapper < Pipeline::TransformMapper
  define_mappings({
    'ProjectCodeID' => { :to => :project_code_id},'Project' => { :to => :project},'Description' => { :to => :description}
  })
end
