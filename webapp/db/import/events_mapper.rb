require File.join(Rails.root, 'db', 'import', 'prospektor_pipeline')

class EventsMapper < Pipeline::TransformMapper
  # include ProspektorPipeline
  
  after_save do |fields, data, model|
    Comment.new(:lead => model.lead, :user => model.user, :comment => data['Memo']).save if data['Memo'] and data['Memo'].length > 0
  end
  
  define_mappings({
    'LeadID' => { :to => :lead_id},
    'BCID' => { :to => :user_id, :transform =>  lambda do |emp_id, context|
                                                  u = User.find_by_employee_id(emp_id)
                                                  u ? u.id : nil
                                                end 
    },
    'Date' => { :to => :created_at }
  })
end