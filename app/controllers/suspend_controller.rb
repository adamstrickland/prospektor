class SuspendController < ApplicationController
  def new
    @lead = Lead.find(params[:lead_id])
    respond_to do |format|
      format.html { render 'new', :layout => 'modal' }
    end
  end

  def create
    lead = Lead.find(params[:lead_id])
    user = User.find(params[:user_id])
    msg = params[:comment]
  
    event = Event.new
    event.type = 'Lead'
    event.action = 'Suspend'
    event.lead = lead
    event.user = user
  
    respond_to do |format|
      if event.save    
        lead.suspend
        lead.save!
    
        if msg and !msg.nil?
          comment = Comment.new
          comment.comment = msg
          comment.lead = lead
          comment.user = user
          comment.save!
        end
      
        format.html { render :partial => 'events/listing_item', :locals => { :event => event } }
      else
        format.html { render :partial => 'common/errors', :status => :unprocessable_entity, :locals => { :errors => event.errors } }
      end
    end
  end
end
