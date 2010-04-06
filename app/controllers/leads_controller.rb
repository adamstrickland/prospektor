class LeadsController < ApplicationController
  # GET /leads
  # GET /leads.xml
  def index
    page = params[:page] || 1
    
    respond_to do |format|
      if params.key?(:user_id)
        unless current_user.is_admin? or current_user.id == params[:user_id].to_i
          format.html{ render :action => 'error' }
          format.ajax{ render :action => 'error.html' }
        else
          @leads = User.find(params[:user_id]).leads.paginate :page => page
          format.html{  }
          format.ajax{ render :action => 'show.html' }
        end
      else
        unless current_user.is_admin?
          format.html{ render :action => 'error' }
          format.ajax{ render :action => 'error.html' }
        else
          @leads = Lead.all.paginate :page => page
          format.html{  }
          format.ajax{ render :action => 'show.html' }
        end
      end
    end
  end

  def call_manager
    @user = User.find(params[:user_id])
    
    next_lead = @user.next_lead_in_queue
    
    if next_lead.blank?
      redirect_to empty_user_leads_url(@user)
    else  
      redirect_to user_lead_url(@user, next_lead)
    end
  end

  # GET /leads/1
  # GET /leads/1.xml
  def show
    respond_to do |format|
      @lead = Lead.find(params[:id])
      if current_user.is_admin? or current_user == @lead.owner or current_user.id == params[:user_id].to_i
        UserEvent.access_lead(@lead, current_user)
        format.html{}
        format.ajax{ render :action => 'show.html' }
      else  
        format.html{ render :action => 'error' }
        format.ajax{ render :action => 'error.html' }
      end
    end
  end
  
  def history
    @lead = Lead.find(params[:id])
    respond_to do |format|
      format.html do
        render :partial => 'history'
      end
    end
  end
  
  def details
    @lead = Lead.find(params[:id])
    respond_to do |format|
      format.html do
        render :partial => 'details'
      end
    end
  end
  
  def find_by_phone
    lead = Lead.find_by_phone(params[:phone])
    if lead.nil?
      if current_user.roles.map(&:title).include?('admin')
        redirect_to :controller => 'admin/dashboard' 
      else
        redirect_to '/' 
      end
    else
      redirect_to :action => 'show', :id => lead.id
    end
  end

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
    render 'edit', :layout => false
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
        format.json { render :json => @lead }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lead.errors, :status => :unprocessable_entity }
        format.json { render :json => @lead.errors  }
      end
    end
  end
  
  # PUT /leads/:id/demographics
  def demographics
    @lead = Lead.find(params[:id])
    render :partial => 'demographics'
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
