require 'digest/sha1'
class DashboardController < ApplicationController
  def index
    unless current_user.nda_accepted?
      render 'nda'
    else
      if current_user.respond_to?('first_time?') and current_user.first_time?
        current_user.first_time = false
        current_user.save
        render 'first_time'
      else
        render 'index'
      end
    end
  end
  
  def terms
    accept_nda = params[:commit] == 'I Accept'
    if accept_nda
      current_user.nda_accepted = true
      current_user.save
      redirect_to :action => 'index'
    else
      current_user.activated_at = nil
      current_user.activation_code = 'DECLINED NDA'
      current_user.save
      redirect_to :controller => 'sessions', :action => 'destroy'
    end
  end
end
