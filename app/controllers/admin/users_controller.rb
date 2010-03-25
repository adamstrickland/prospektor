class Admin::UsersController < Admin::AdminController
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.all.reject{|u| u.employee.blank? or not u.active? }.paginate :page => params[:page] || 1, :per_page => 25

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  def reset_password
    respond_to do |format|
      format.json do
        @user = User.find(params[:id])
        new_password = User.generate_password
        @user.password = new_password
        @user.password_confirmation = new_password
        @user.encrypt_password  # needed to make record dirty so can be picked up by observer
        if @user.save
          head :ok
        else
          head :bad_request
        end
      end
    end
  end
  
  def deactivate
    respond_to do |format|
      format.json do
        @user = User.find(params[:id])
        @user.activation_code = 'DEACTIVATED'
        @user.activated_at = nil
    
        if @user.save
          head :ok
        else
          head :bad_request
        end
      end
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
