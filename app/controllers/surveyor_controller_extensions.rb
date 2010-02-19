require File.join(File.dirname(__FILE__), '..', 'models', 'response_set_extensions')

module SurveyorControllerExtensions
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      # Same as typing in the class
      skip_before_filter :login_required
      after_filter :capture_lead_as_responder, :only => [:create]
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
    def get_bcr
      @survey_code = 'bcr'
      @identifiers = [
        { :key => 'key', :value => params[:key] }
      ]
      render 'autotake'
    end
    
    def results
      @response_set = ResponseSet.find_by_access_code(params[:response_set_code])
      if @response_set.blank?
        render :unknown
      else
        @survey = @response_set.survey
        @lead = Lead.find(@response_set.lead_id)
        case @survey.access_code
        when 'bcr' 
          @categories = ['Progressive', 'Average', 'Weak', 'N/A']
          respond_to do |format|
            format.html{ render :bcr_results }
            format.json do
              response_data = {
                'piechart' => @categories.map{ |ans|
                  [ans, @response_set.responses.select{|resp| resp.answer.short_text == ans[0].chr.downcase}.count]
                }
              }
              if @response_set.responses.map{|r| r.question.survey_section.title.downcase}.include?('manufacturing')
                response_data.merge!({ 
                  'barchart' => @categories.map{ |ans|
                    [ans, @response_set.responses.select{|r| r.question.survey_section.title.downcase == 'manufacturing'}.select{|resp| resp.answer.short_text == ans[0].chr.downcase}.count]
                  }
                })
              end
              render :json => response_data
            end
          end
        else 
          render :generic_results
        end
      end
    end
    
    protected
    
    def capture_lead_as_responder
      if params.has_key?(:key) or params.has_key?('key')
        rs = @response_set || ResponseSet.find_by_access_code(params[:response_set_code])
        unless rs.lead_id?
          lead = Lead.find_by_key(params[:key])
          if lead.present?
            rs.lead_id = lead.id
            rs.save
          end
        end
      end
    end
    
    def finish_path
      survey_results_path(:response_set_code => params[:response_set_code])
    end
  end
  
  module Actions
    # Redefine the controller actions [index, new, create, show, update] here
  end
end
