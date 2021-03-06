# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  skip_before_filter :login_required, :check_timeout

  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Event.new(:user => user, :action => 'login', :qualifier => 'success').save
      UserEvent.login_success(user)
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default(dashboard_url)
      flash[:notice] = "Logged in successfully"
    else
      UserEvent.login_failed(user)
      # Event.new(:user => user, :action => 'login', :qualifier => 'failed').save
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    UserEvent.logout(current_user)
    # Event.new(:user => current_user, :action => 'logout').save
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

  def check_timeout
    respond_to do |format|
      format.json {
        if session_expired?
          logout_keeping_session!
          render :json => { :status => :expired }.to_json
        else
          render :json => { :status => :ok }.to_json
        end
      }
    end
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
