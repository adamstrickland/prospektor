class DashboardController < ApplicationController
  def index
    if current_user.respond_to?('first_time?') and current_user.first_time?
      current_user.first_time = false
      current_user.save
      render 'first_time'
    else
      render 'index'
    end
  end
end
