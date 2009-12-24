require 'uuidtools'

class PresentationsController < ApplicationController
  # # GET /presentations
  # # GET /presentations.xml
  # def index
  #   @presentations = Presentation.all
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @presentations }
  #   end
  # end
  # 
  # # GET /presentations/1
  # # GET /presentations/1.xml
  # def show
  #   @presentation = Presentation.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @presentation }
  #   end
  # end

  # GET /presentations/new
  # GET /presentations/new.xml
  def new
    @presentation = Presentation.new
    @lead = Lead.find(params[:lead_id])
    @presentation.email = @lead.email
    @touchpoint = Touchpoint.new( :call_window_start_at => Time.now + 15.minutes )

    respond_to do |format|
      format.html { render 'new', :layout => 'modal' }
      format.xml  { render :xml => @presentation }
    end
  end

  # # GET /presentations/1/edit
  # def edit
  #   @presentation = Presentation.find(params[:id])
  # end

  # POST /presentations
  # POST /presentations.xml
  def create
    @presentation = Presentation.new(params[:presentation])
    @presentation.url = generate_url('http://demo.trigonsolutions.com/demo')
    @presentation.user = current_user
    
    lead = Lead.find_by_id(params[:lead_id])
    @presentation.lead = lead
    
    @touchpoint = Touchpoint.new(params[:touchpoint])
    @touchpoint.lead = lead
    @touchpoint.call_queue = lead.touchpoints.last.call_queue

    respond_to do |format|
      if @presentation.save and @touchpoint.save
        format.html { render :partial => 'events/listing_item', :locals => { :event => lead.events.last } }
      else
        format.html { render :partial => 'common/errors', :status => :unprocessable_entity, :locals => { :errors => @presentation.errors } }
      end
    end
  end

  # # PUT /presentations/1
  # # PUT /presentations/1.xml
  # def update
  #   @presentation = Presentation.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @presentation.update_attributes(params[:presentation])
  #       flash[:notice] = 'Presentation was successfully updated.'
  #       format.html { redirect_to(@presentation) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @presentation.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # DELETE /presentations/1
  # # DELETE /presentations/1.xml
  # def destroy
  #   @presentation = Presentation.find(params[:id])
  #   @presentation.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(presentations_url) }
  #     format.xml  { head :ok }
  #   end
  # end
  
  private
  def generate_url(prefix='')
    'http://connectpro60851448.acrobat.com/information/'
    # uuid = UUIDTools::UUID.timestamp_create.to_s
    # "#{prefix}/#{uuid}"
  end
end
