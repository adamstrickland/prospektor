require File.join(File.dirname(__FILE__), '..', 'models', 'response_set_extensions')

module SurveyorControllerExtensions
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      # Same as typing in the class
      skip_before_filter :login_required
      # before_filter :capture_lead_as_responder, :only => [:edit, :update]
      after_filter :capture_lead_as_responder, :only => [:create]
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
    # def get_bcr
    #   # key = params[:key]
    #   # post :create, :survey_code => 'bcr', :key => params[:key]
    #   params[:survey_code] ||= 'bcr'
    #   self.create
    # end
    def get_bcr
      @survey_code = 'bcr'
      @identifiers = [
        { :key => 'key', :value => params[:key] }
      ]
      render 'autotake'
    end
    
    protected
    
    def capture_lead_as_responder
      # debugger
      if params.has_key?(:key) or params.has_key?('key')
        rs = @response_set || ResponseSet.find_by_access_code(params[:response_set_code])
        # unless rs.has_lead?
        unless rs.lead_id?
          lead = Lead.find_by_key(params[:key])
          if lead.present?
            rs.lead_id = lead
            rs.save
          end
        end
      end
    end
  end
  
  module Actions
    # Redefine the controller actions [index, new, create, show, update] here
  end
end
