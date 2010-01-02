class DispositionController < ApplicationController
  def new
    @lead = Lead.find(params[:lead_id])
    
    if @lead
    
    
    @disposition_options = {
      'Call back (no answer)' => :reassign,
      'Left message' => :reassign,
      'Call back (answer)' => :reassign,
      "Opt out" => :suspend,
      'Invalid number' => :orphan,
      'No Thanks' => :suspend
    }

    respond_to do |format|
      format.html { render 'new', :layout => 'modal' }
    end
  end

  def create
    lead = Lead.find(params[:lead_id])
    user = current_user
    msg = params[:comment]
    transition = params[:disposition]
    
    respond_to do |format|
      Comment.new(:comment => msg, :lead => lead, :user => current_user).save if msg
      
      lead.send(transition)
      if lead.save
        format.json{
          render :json => { :status => :success }
        }
      else
        format.json{
          render :json => { :status => :failure, :errors => lead.errors }
        }
      end
      
      # format.html{ redirect_to user_call_queue_touchpoint_url(current_user, @queue, @touchpoint.next) }
      
      #   
      #   format.html { render :partial => 'events/listing_item', :locals => { :event => event } }
      # else
      #   format.html { render :partial => 'common/errors', :status => :unprocessable_entity, :locals => { :errors => event.errors } }
      # end
    end
  end
end
