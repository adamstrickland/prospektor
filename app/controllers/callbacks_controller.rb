class CallbacksController < ApplicationController
  # GET /callbacks
  # GET /callbacks.xml
  def index
    @callbacks = Callback.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @callbacks }
    end
  end

  # GET /callbacks/1
  # GET /callbacks/1.xml
  def show
    @callback = Callback.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @callback }
    end
  end

  # GET /callbacks/new
  # GET /callbacks/new.xml
  def new
    @callback = Callback.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @callback }
    end
  end

  # GET /callbacks/1/edit
  def edit
    @callback = Callback.find(params[:id])
  end

  # POST /callbacks
  # POST /callbacks.xml
  def create
    @callback = Callback.new(params[:callback])

    respond_to do |format|
      if @callback.save
        flash[:notice] = 'Callback was successfully created.'
        format.html { redirect_to(@callback) }
        format.xml  { render :xml => @callback, :status => :created, :location => @callback }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @callback.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /callbacks/1
  # PUT /callbacks/1.xml
  def update
    @callback = Callback.find(params[:id])

    respond_to do |format|
      if @callback.update_attributes(params[:callback])
        flash[:notice] = 'Callback was successfully updated.'
        format.html { redirect_to(@callback) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @callback.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /callbacks/1
  # DELETE /callbacks/1.xml
  def destroy
    @callback = Callback.find(params[:id])
    @callback.destroy

    respond_to do |format|
      format.html { redirect_to(callbacks_url) }
      format.xml  { head :ok }
    end
  end
end
