class Admin::ApplicantsController < Admin::AdminController
  
  # GET /applicants
  # GET /applicants.xml
  def index
    # @applicants = Applicant.all.sort_by{|f,l| [f.applicantlastname, f.applicantfirstname] <=> [l.applicantlastname, l.applicantfirstname] }
    @applicants = Applicant.open.paginate :page => params[:page] || 1, :per_page => 25
    # .sort_by{|f,l| l.id <=> f.id } # sorted by ID (since no date) DESC

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @applicants }
    end
  end

  # GET /applicants/1
  # GET /applicants/1.xml
  def show
    @applicant = Applicant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @applicant }
    end
  end

  # GET /applicants/new
  # GET /applicants/new.xml
  def new
    @applicant = Applicant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @applicant }
    end
  end

  # GET /applicants/1/edit
  def edit
    @applicant = Applicant.find(params[:id])
  end

  # POST /applicants
  # POST /applicants.xml
  def create
    @applicant = Applicant.new(params[:applicant])

    respond_to do |format|
      if @applicant.save
        flash[:notice] = 'Applicant was successfully created.'
        format.html { redirect_to(@applicant) }
        format.xml  { render :xml => @applicant, :status => :created, :location => @applicant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @applicant.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def onboard
    respond_to do |format|
      format.json do
        @applicant = Applicant.find(params[:id])
        if @applicant
          @employee = @applicant.create_employee
          if @employee
            if @employee.save
              @user = @employee.create_user
              if @user
                if @user.save
                  render :json => { :status => :ok, :user => { :login => @user.login, :name => @employee.full_name }}
                else
                  render :json => { :status => :unprocessable_entity, :errors => @user.errors }
                end
              else
                render :json => { :status => :unprocessable_entity, :message => 'User could not be created' }
              end
            else
              render :json => { :status => :unprocessable_entity, :errors => @employee.errors }
            end
          else
            render :json => { :status => :unprocessable_entity, :message => 'Employee could not be created' }
          end
        else
          render :json => { :status => :unprocessable_entity, :message => 'Applicant could not be found' }
        end
      end
    end
  end
  
  def reject
    respond_to do |format|
      format.json do
        @applicant = Applicant.find(params[:id])
        @applicant.rejected = true
        if @applicant.save
          head :ok
        else
          render :json => @applicant.errors, :status => :unprocessable_entity
        end
      end
    end
  end
      

  # PUT /applicants/1
  # PUT /applicants/1.xml
  def update
    @applicant = Applicant.find(params[:id])

    respond_to do |format|
      if @applicant.update_attributes(params[:applicant])
        flash[:notice] = 'Applicant was successfully updated.'
        format.html { redirect_to(@applicant) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @applicant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /applicants/1
  # DELETE /applicants/1.xml
  def destroy
    @applicant = Applicant.find(params[:id])
    @applicant.destroy

    respond_to do |format|
      format.html { redirect_to(applicants_url) }
      format.xml  { head :ok }
    end
  end
end
