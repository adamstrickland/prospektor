require 'chronic'
require 'tzinfo'

class CallBacksController < ApplicationController
  skip_before_filter :login_required, :only => [:create]
  
  # GET /callbacks
  # GET /callbacks.xml
  def index
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html do
        @callbacks = @user.call_backs
        render
      end
      format.json do
        @callbacks = @user.call_backs || []
        # @callbacks = (5.days.ago..10.days.from_now).map{ |d| CallBack.new( :user => @user, :lead => Lead.first, :callback_at => d)}
        # @callbacks = [CallBack.new(:user => @user, :lead => Lead.first, :callback_at => Chronic.parse("#{Date.today} 12:00pm"))]
        full_calendar_response = @callbacks.uniq.map do |cb|
          mapping_base = {
            :id => cb.id,
            :title => cb.lead.company,
            # :url => lead_url(cb.lead),
            :start => cb.callback_at
          }
          
          if cb.callback_at.seconds_since_midnight == 0
            mapping_base.merge({ :allDay => true })
          else
            mapping_base.merge({ :allDay => false, :end => cb.callback_at + 15.minutes})
          end
        end
        render :json => full_calendar_response
      end
    end
  end

  # # GET /callbacks/1
  # # GET /callbacks/1.xml
  # def show
  #   @callback = CallBack.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @callback }
  #   end
  # end
  # 
  # # GET /callbacks/new
  # # GET /callbacks/new.xml
  # def new
  #   @callback = CallBack.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @callback }
  #   end
  # end
  # 
  # # GET /callbacks/1/edit
  # def edit
  #   @callback = CallBack.find(params[:id])
  # end
  
  # POST /callbacks
  # POST /callbacks.xml
  def create
    respond_to do |format|
      format.json do
        @callback = CallBack.new
        @lead = Lead.find(params[:lead_id])
        @user = User.find(params[:user_id])
        @callback.lead = @lead
        @callback.user = @user
        @callback.status = CallBackStatus.find_by_code('UN')
        @callback.callback_at = if params[:callback_at].present?
          params[:callback_at]
        else
          lead_tz = TZInfo::Timezone.us_zones.detect{ |z| z.current_period.utc_offset/60/60 == @lead.gmt_offset }
          if lead_tz and lead_tz.utc_to_local(Time.now.utc).hour >= 17
            # schedule for tomorrow morning 9am in the lead's tz
            lead_tz.local_to_utc(Chronic.parse('tomorrow 9am'))
          else
            3.minutes.from_now
          end
        end
        
        if @callback.save
          head :ok
        else
          render :json => @callback.errors, :status => :unprocessable_entity
        end
      end
    end
  end
  
  # PUT /callbacks/1
  # PUT /callbacks/1.xml
  def update
    respond_to do |format|
      format.json do
        @callback = CallBack.find(params[:id])
        # if @callback.update_attributes(params.reject{|k,v| ![:callback_at].include?(k)})
        @callback.callback_at = params[:callback_at]
        if @callback.save
          head :ok
        else
          render :json => @callback.errors, :status => :unprocessable_entity
        end
      end
    end
    # @callback = CallBack.find(params[:id])
    #   
    # respond_to do |format|
    #   if @callback.update_attributes(params[:callback])
    #     flash[:notice] = 'Callback was successfully updated.'
    #     format.html { redirect_to(@callback) }
    #     format.xml  { head :ok }
    #   else
    #     format.html { render :action => "edit" }
    #     format.xml  { render :xml => @callback.errors, :status => :unprocessable_entity }
    #   end
    # end
  end
  
  # # DELETE /callbacks/1
  # # DELETE /callbacks/1.xml
  # def destroy
  #   @callback = CallBack.find(params[:id])
  #   @callback.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(callbacks_url) }
  #     format.xml  { head :ok }
  #   end
  # end
end
