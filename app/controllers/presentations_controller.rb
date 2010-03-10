require 'uuidtools'

class PresentationsController < ApplicationController
  # GET /presentations/new
  # GET /presentations/new.xml
  def new
    @presentation = Presentation.new
    @lead = Lead.find(params[:lead_id])
    @presentation.email = @lead.email
    # @touchpoint = Touchpoint.new( :call_window_start_at => Time.now + 15.minutes )
    @topics = InformationTopic.all.sort_by{ |t| t.name }.map{ |t| [t.name, t.id] }

    respond_to do |format|
      format.html { render 'new', :layout => 'modal' }
      format.xml  { render :xml => @presentation }
    end
  end

  # POST /presentations
  # POST /presentations.xml
  def create
    lead = Lead.find_by_id(params[:lead_id])
  
    @presentation = Presentation.new(params[:presentation])
    @presentation.lead = lead
    @presentation.url = "#{@presentation.topic.url}?key=#{lead.key}"
    @presentation.user = current_user
    

    respond_to do |format|
      if @presentation.save
        lead.status = LeadStatus.find_by_code('INV')
        lead.save
        
        format.json{
          render :json => { :status => :success }
        }
      else
        format.json{
          render :json => { :status => :failure, :errors => @presentation.errors }
        }
      end
    end
  end
end
