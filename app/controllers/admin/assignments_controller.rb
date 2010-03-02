class Admin::AssignmentsController < ApplicationController
  layout 'admin'
  
  # GET /assignments
  # GET /assignments.xml
  def index
    @user = User.find(params[:user_id])
    @assignments = @user.assignments.paginate :page => params[:page] || 1, :order => 'company ASC', :per_page => 25

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assignments }
    end
  end

  # GET /assignments/1
  # GET /assignments/1.xml
  def show
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      format.html{ render 'show', :layout => false }
    end
  end
  
  def bulk
    @user = User.find(params[:user_id])
    # render :file => 'admin/assignments/block', :layout => false
    # render 'block', :layout => false
    # render :partial => 'foo', :locals => { :user => @user }
    render 'bulk', :layout => false
  end
  
  # def new_block
  #   render 'new_block', :layout => false
  # end
  # 
  # def all_leads
  #   render 'all_leads', :layout => false
  # end
  # 
  # def create_block
  #   respond_to do |format|
  #     format.json do
  #       amount = params[:size] || 500
  #       user = User.find(params[:id])
  #       leads = Lead.generate_leads_for_user(user, amount)
  #       user.leads = leads
  #       if user.save
  #         head :ok
  #       else
  #         head :unprocessable_entity
  #       end
  #     end
  #   end
  # end
  
  def search
  end

  # GET /assignments/new
  # GET /assignments/new.xml
  def new
    @assignment = Assignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.xml
  def create
    block_size = params[:size].to_i || 500
    user = User.find(params[:user_id])
    emp_state = user.employee.state_or_province
    state_leads = Lead.open.located_in_state_of(emp_state)
    possible_leads = state_leads.count < block_size ? Lead.open.located_in_timezone_of(emp_state) : state_leads
    assignments = possible_leads[0..(block_size - 1)]
    user.leads << assignments
    
    respond_to do |format|
      format.json do
        if user.save
          render :json => {:assignments => assignments.size}, :status => :ok
        else
          render :json => user.errors, :status => :unprocessable_entity
        end
      end
    end
  end

  # PUT /assignments/1
  # PUT /assignments/1.xml
  def update
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        flash[:notice] = 'Assignment was successfully updated.'
        format.html { redirect_to(@assignment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.xml
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to(assignments_url) }
      format.xml  { head :ok }
    end
  end
end
