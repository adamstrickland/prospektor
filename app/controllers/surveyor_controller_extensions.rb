require File.join(Rails.root, 'vendor', 'plugins', 'surveyor', 'app', 'models', 'response_set')
# require File.join(Rails.root, 'app', 'models', 'response_set')

module SurveyorControllerExtensions
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      # Same as typing in the class
      skip_before_filter :login_required
      before_filter :capture_lead_as_responder, :only => [:edit, :update]
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
    protected
    
    def capture_lead_as_responder
      rs = ResponseSet.find_by_access_code(params[:response_set_code])
      unless rs.has_lead?
        lead = Lead.find_by_key(params[:key])
        if lead.present?
          rs.lead = lead
          rs.save
        end
      end
    end
  end
  
  module Actions
    # Redefine the controller actions [index, new, create, show, update] here
  end
end
