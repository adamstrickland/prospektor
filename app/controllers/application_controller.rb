# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  before_filter :login_required
  # before_filter :prepare_session
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
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
