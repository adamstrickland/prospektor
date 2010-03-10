class CallManagerController < ApplicationController
  def next
    @user = User.find(params[:user_id])
    
    #TODO: need to figure out how to find recently missed callbacks...
    
    # check to see if @user.callbacks has something in the next 3 minutes
    near_callbacks = @user.call_backs.window(4.minutes.from_now, 0.minutes.from_now)
    
    # if so, show that lead
    # if not, pull one off @user.leads
    if near_callbacks.present?
      redirect_to user_lead_url(@user, near_callbacks.first.lead)
    else
      ready_leads = @user.leads.valid
      if ready_leads.present?
        redirect_to user_lead_url(@user, ready_leads.first)
      else
        redirect_to user_leads_empty_url(@user)
      end
    end
  end
end
