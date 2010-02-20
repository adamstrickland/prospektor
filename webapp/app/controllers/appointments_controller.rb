

class AppointmentsController < ApplicationController
  # # GET /appointments
  # # GET /appointments.xml
  # def index
  #   @appointments = Appointment.all
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @appointments }
  #   end
  # end
  # 
  # # GET /appointments/1
  # # GET /appointments/1.xml
  # def show
  #   @appointment = Appointment.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @appointment }
  #   end
  # end

  # GET /appointments/new
  # GET /appointments/new.xml
  def new
    @appointment = Appointment.new
    @lead = Lead.find(params[:lead_id])
    @appointment.client_email = @lead.presentations.last.email || @lead.email
    # @appointment.location = "#{@lead.address}, #{@lead.city} #{@lead.state}"
    @appointment.location = @lead.phone
    default_date = Date.tomorrow
    @appointment.session_date = default_date
    @appointment.session_time = default_date.to_datetime + 9.hours # 9am, tomorrow

    respond_to do |format|
      format.html { render 'new', :layout => 'modal' }
      format.xml  { render :xml => @appointment }
    end
  end

  # # GET /appointments/1/edit
  # def edit
  #   @appointment = Appointment.find(params[:id])
  # end

  # POST /appointments
  # POST /appointments.xml
  def create
    @appointment = Appointment.new(params[:appointment])
    @appointment.scheduler = current_user
    @appointment.lead = Lead.find(params[:lead_id])
    @appointment.expert_email = get_expert
    # @appointment.topic = Topic.find

    respond_to do |format|
      if @appointment.save
        format.json{
          render :json => { :status => :success }
        }
      else
        format.json{
          render :json => { :status => :failure, :errors => @appointment.errors }
        }
      end
      # if @appointment.save
      #   format.html { render :partial => 'events/listing_item', :locals => { :event => e } }
      # else
      #   format.html { render :partial => 'common/errors', :status => :unprocessable_entity, :locals => { :errors => @appointment.errors } }
      # end
    end
  end

  # # PUT /appointments/1
  # # PUT /appointments/1.xml
  # def update
  #   @appointment = Appointment.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @appointment.update_attributes(params[:appointment])
  #       flash[:notice] = 'Appointment was successfully updated.'
  #       format.html { redirect_to(@appointment) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @appointment.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # DELETE /appointments/1
  # # DELETE /appointments/1.xml
  # def destroy
  #   @appointment = Appointment.find(params[:id])
  #   @appointment.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(appointments_url) }
  #     format.xml  { head :ok }
  #   end
  # end  
    
  protected
    def get_expert
      if Rails.configuration.environment.downcase == 'production'
        'lluarca@trigonsolutions.com'
      else
        'adam.strickland+expert@gmail.com'
      end
    end
end
