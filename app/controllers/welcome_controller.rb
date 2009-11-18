class WelcomeController < ApplicationController
  skip_before_filter :login_required
  
  def index
    if logged_in?
      redirect_to user_dashboard_url(current_user)
    else
      render :index
    end
  end
end
