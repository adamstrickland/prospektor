require 'uuidtools'

class PresentationsController < ApplicationController
  # GET /presentations/new
  # GET /presentations/new.xml
  def new
    respond_to do |format|
      format.html do
        @presentation = Presentation.new
        @lead = Lead.find(params[:lead_id])
        @presentation.email = @lead.email
        @topics = Topic.all.sort_by{ |t| t.name }.map{ |t| [t.name, t.id] }
        
        render 'new', :layout => 'modal'
      end
    end
  end

  # POST /presentations
  # POST /presentations.xml
  def create
    respond_to do |format|
      format.json do
        @lead = Lead.find_by_id(params[:lead_id])
  
        @presentation = Presentation.new(params[:presentation])
        @presentation.lead = @lead
        @presentation.url = "#{@presentation.topic.url}?key=#{@lead.key}"
        @presentation.user = current_user
      
        @lead.status = LeadStatus.find_by_code('INV')
        @lead.email = @presentation.email

        if @presentation.save and @lead.save
          head :ok
        else
          render :json => @presentation.errors + @lead.errors, :status => :unprocessable_entity
        end
      end
    end
  end
end
