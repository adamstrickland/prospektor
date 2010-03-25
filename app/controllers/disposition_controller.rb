require 'chronic'

class DispositionController < ApplicationController
  def new
    @lead = Lead.find(params[:lead_id])
    @disposition_options = LeadStatus.all.reject{|s| ['CB', 'CLIENT', 'INV', 'VM'].include?(s.code)}.map{|s| ["#{s.code} - #{s.description}", s.code] }
    respond_to do |format|
      format.html { render 'new', :layout => 'modal' }
    end
  end

  def create
    respond_to do |format|
      @lead = Lead.find(params[:lead_id])
      @user = current_user
    
      if params[:disposition] == 'BS'
        # notify of sale, set status to CB
        # ProspectMailer.deliver_scheduled_appointment(appt)
        Notifier.deliver_booked_sale(@lead)
        @status = LeadStatus.find_by_code('CB')
      else
        if ['CB','RS','VM'].include?(params[:disposition])
          # create a callback, set status to @status
          callback_at = if params[:callback_at]
                          Chronic.parse(params[:callback_at])
                        else
                          if params[:date]
                            Time.new(params[:date])
                          else
                            Chronic.parse('tomorrow at 9am')
                          end
                        end
          callback = CallBack.new(:user => @user, :callback_at => callback_at, :status => CallBackStatus.find_by_code('UN'))
          @lead.call_backs << callback
        end
        @status = LeadStatus.find_by_code(params[:disposition]) # || LeadStatus.find(params[:disposition])
      end
    
      @lead.status = @status
      @lead.comments << Comment.new(:comment => params[:comments], :user => current_user) if params[:comments].present?
    
      format.json do
        if @lead.save
          head :ok
        else
          render :json => @lead.errors, :status => :unprocessable_entity
        end
      end
    end
  end
end
