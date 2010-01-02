class DashboardController < ApplicationController
  def index
    if current_user.respond_to?('first_time?') and current_user.first_time?
      render 'first_time'
    else
      render 'index'
    end
  end

end
