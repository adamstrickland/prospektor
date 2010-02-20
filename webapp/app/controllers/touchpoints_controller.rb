class TouchpointsController < ApplicationController
  # GET /touchpoints
  # GET /touchpoints.xml
  def index
    @touchpoints = Touchpoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @touchpoints }
    end
  end

  # GET /touchpoints/1
  # GET /touchpoints/1.xml
  def show
    @touchpoint = Touchpoint.find(params[:id])
    @queue = CallQueue.find(params[:call_queue_id])
    
    @lead = @touchpoint.lead

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @touchpoint }
    end
  end

  # # GET /touchpoints/new
  # # GET /touchpoints/new.xml
  # def new
  #   @touchpoint = Touchpoint.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @touchpoint }
  #   end
  # end
  # 
  # # GET /touchpoints/1/edit
  # def edit
  #   @touchpoint = Touchpoint.find(params[:id])
  # end
  # 
  # # POST /touchpoints
  # # POST /touchpoints.xml
  # def create
  #   @touchpoint = Touchpoint.new(params[:touchpoint])
  # 
  #   respond_to do |format|
  #     if @touchpoint.save
  #       flash[:notice] = 'Touchpoint was successfully created.'
  #       format.html { redirect_to(@touchpoint) }
  #       format.xml  { render :xml => @touchpoint, :status => :created, :location => @touchpoint }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @touchpoint.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # PUT /touchpoints/1
  # # PUT /touchpoints/1.xml
  # def update
  #   @touchpoint = Touchpoint.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @touchpoint.update_attributes(params[:touchpoint])
  #       flash[:notice] = 'Touchpoint was successfully updated.'
  #       format.html { redirect_to(@touchpoint) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @touchpoint.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # DELETE /touchpoints/1
  # # DELETE /touchpoints/1.xml
  # def destroy
  #   @touchpoint = Touchpoint.find(params[:id])
  #   @touchpoint.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(touchpoints_url) }
  #     format.xml  { head :ok }
  #   end
  # end
  protected
    def priority_touchpoint(this_tp)
    end
end
