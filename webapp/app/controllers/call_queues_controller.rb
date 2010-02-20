class CallQueuesController < ApplicationController
  # GET /queues
  # GET /queues.xml
  def index
    @queues = current_user.call_queues

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @queues }
    end
  end

  # GET /queues/1
  # GET /queues/1.xml
  def show
    @queue = CallQueue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @queue }
    end
  end

  # GET /queues/new
  # GET /queues/new.xml
  def new
    t = Date.today
    @queue = CallQueue.new
    @queue.name = "Calls for #{t.to_s}"
    @queue.queue_date = t

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @queue }
    end
  end

  # GET /queues/1/edit
  def edit
    @queue = CallQueue.find(params[:id])
  end
  
  def create
    @queue = CallQueue.new
    t = Date.today
    @queue.name = "Calls for #{t.to_s}"
    @queue.queue_date = t
    @queue.user = User.find(params[:user_id])
    @queue.leads = current_user.ready_leads
    
    respond_to do |format|
      if @queue.save
        # @queue.leads.each do |l|
        #   if l.aasm_state == 'assigned'
        #     l.enqueue
        #   end
        #   l.save
        # end
        
        format.html { 
          if @queue.touchpoints.length == 0
            redirect_to empty_user_call_queue_url(current_user, @queue)
          else
            redirect_to user_call_queue_touchpoint_url(current_user, @queue, @queue.touchpoints.first)
          end
        }
        format.xml  { render :xml => @queue, :status => :created, :location => @queue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @queue.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def empty
  end

  # # POST /queues
  # # POST /queues.xml
  # def create
  #   @queue = CallQueue.new(params[:queue])
  #   @queue.user = User.find(params[:user_id])
  #   @queue.leads = get_leads_for_queue
  #   
  #   respond_to do |format|
  #     if @queue.save!
  #       @queue.leads.each do |l|
  #         if l.assigned
  #           l.enqueue
  #         end
  #         l.save!
  #       end
  #       flash[:notice] = 'Call Queue was successfully created.'
  #       format.html { 
  #         redirect_to user_call_queue_lead_url(current_user.id, @queue.id, @queue.leads.first.id)
  #       }
  #       format.xml  { render :xml => @queue, :status => :created, :location => @queue }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @queue.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # PUT /queues/1
  # PUT /queues/1.xml
  def update
    @queue = CallQueue.find(params[:id])

    respond_to do |format|
      if @queue.update_attributes(params[:queue])
        flash[:notice] = 'Call Queue was successfully updated.'
        format.html { redirect_to(@queue) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @queue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /queues/1
  # DELETE /queues/1.xml
  def destroy
    @queue = CallQueue.find(params[:id])
    @queue.destroy

    respond_to do |format|
      format.html { redirect_to(queues_url) }
      format.xml  { head :ok }
    end
  end
end
