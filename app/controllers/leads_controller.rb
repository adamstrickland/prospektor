class LeadsController < ApplicationController
  # GET /leads
  # GET /leads.xml
  def index
    # @leads = Lead.all
    @leads = Lead.queued.paginate_by_user_id params[:user_id], :page => (params[:page] || 1)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leads }
    end
  end

  # GET /leads/1
  # GET /leads/1.xml
  def show
    @lead = Lead.find(params[:id])
    leads = Lead.queued.owned_by(params[:user_id])
    current_index = leads.index(@lead)
    next_index = (current_index+1 == leads.count ? 0 : current_index+1)
    @lead.next_id = leads[next_index].id

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lead }
    end
  end
  
  # def next
  #   current_lead = Lead.find(params[:id])
  #   current_index = leads.index(current_lead)
  #   next_index = (current_index+1 == leads.count ? 0 : current_index+1)
  #   next_id = leads[next_index].id
  #   @lead = Lead.find(next_id)
  # 
  #   respond_to do |format|
  #     format.html { render :action => 'show' }
  #     format.xml  { render :xml => @lead }
  #   end
  # end
  
  def disposition
    @lead = Lead.find(params[:id])

    respond_to do |format|
      format.html { render 'disposition', :layout => 'modal' }
      # format.xml  { render :xml => @lead }
    end
  end
  
  # def invite
  #   @lead = Lead.find(params[:id])
  # end
  # 
  # def book
  # end
  # 
  # def disposition
  # end

  # GET /leads/new
  # GET /leads/new.xml
  def new
    @lead = Lead.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lead }
    end
  end

  # GET /leads/1/edit
  def edit
    @lead = Lead.find(params[:id])
  end

  # POST /leads
  # POST /leads.xml
  def create
    @lead = Lead.new(params[:lead])

    respond_to do |format|
      if @lead.save
        flash[:notice] = 'Lead was successfully created.'
        format.html { redirect_to(@lead) }
        format.xml  { render :xml => @lead, :status => :created, :location => @lead }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lead.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /leads/1
  # PUT /leads/1.xml
  def update
    @lead = Lead.find(params[:id])

    respond_to do |format|
      if @lead.update_attributes(params[:lead])
        flash[:notice] = 'Lead was successfully updated.'
        format.html { redirect_to(@lead) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lead.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1
  # DELETE /leads/1.xml
  def destroy
    @lead = Lead.find(params[:id])
    @lead.destroy

    respond_to do |format|
      format.html { redirect_to(leads_url) }
      format.xml  { head :ok }
    end
  end
end
