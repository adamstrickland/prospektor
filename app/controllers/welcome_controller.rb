class WelcomeController < ApplicationController
  skip_before_filter :login_required
  
  def index
    if logged_in?
      redirect_to dashboard_url
    else
      render :index
    end
  end
end
