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
    'Date' => { :to => :created_at },
    # 'Memo' => { :to => :memo},
    
    # 'Set Date' => { :to => :set_date},
    # 'Set Time' => { :to => :set_time},
    # 'Status' => { :to => :status},
    # 'Recontact Date' => { :to => :recontact_date},
    # 'Recontact Time' => { :to => :recontact_time},
    # 'ApptDate' => { :to => :appt_date},
    # 'ApptTime' => { :to => :appt_time},
    # 'Confirmed' => { :to => :confirmed},
    # 'Faxed' => { :to => :faxed},
    # 'One-Legged' => { :to => :one_legged},
    # 'Rcvd' => { :to => :rcvd},
    # 'Hot Buttons' => { :to => :hot_buttons},
    # 'Prospect Problems' => { :to => :prospect_problems},
    # 'Discuss Competition' => { :to => :discuss_competition},
    # 'History & Success' => { :to => :history_and_success},
    # 'Knows BMC' => { :to => :knows_bmc},
    # 'Bad Experience' => { :to => :bad_experience},
    # 'Prior Consultant' => { :to => :prior_consultant},
    # 'Presentation Scheduled' => { :to => :presentation_scheduled},
    # 'Presentation Scheduled Set With' => { :to => :presentation_scheduled_set_with},
    # 'Presentation Viewed' => { :to => :presentation_viewed},
    # 'Presentation Score' => { :to => :presentation_score},
    # 'Expert Date' => { :to => :expert_date},
    # 'Expert Time' => { :to => :expert_time},
    # 'Expert Set With' => { :to => :expert_set_with},
    # 'Expert Topic' => { :to => :expert_topic},
    # 'Expert Timeframe' => { :to => :expert_timeframe},
    # 'Expert Time Confirmation' => { :to => :expert_time_confirmation},
  })
end