# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  class CustomNotFoundError < RuntimeError; end
  class CustomSystemError < RuntimeError; end
  
  before_filter :login_required
  before_filter :update_activity_time, :except => :session_expiry
  # before_filter :prepare_session
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  # def error
  #   rescue_action_in_public CustomSystemError.new
  # end
  # 
  # def not_found
  #   rescue_action_in_public CustomNotFoundError.new
  # end
  # 
  # def rescue_action_in_public(exception)
  #   case exception
  #     when CustomNotFoundError, ::ActionController::UnknownAction then
  #       render :template => "shared/404", :layout => "error", :status => "404"
  #     else
  #       @message = exception
  #       render :template => "shared/500", :layout => "error", :status => "500"
  #   end
  # end
  
  def update_activity_time
    session[:expires_at] = 30.minutes.from_now
  end
  
  def session_expiry
    @time_left = (session[:expires_at] - Time.now).to_i
    unless @time_left > 0
      logout_keeping_session!
      # redirect_back_or_default(login_url)
      render :partial => 'shared/redirect'
    end
    render :partial => 'shared/session_expiry'
  end
  
  private
  
  # def session_expired?
  #   session[:expires_at] and session[:expires_at] > Time.now
  # end
  # 
  # def prepare_session
  #   logout_keeping_session! if session_expired?
  #   session[:expires_at] = 30.minutes.from_now
  # end
end
