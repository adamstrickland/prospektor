class CallQueuesController < ApplicationController
  # GET /queues
  # GET /queues.xml
  def index
    @queues = CallQueue.by_owner(params[:user_id])

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
  
  def default
    @queue = CallQueue.new
    t = Date.today
    @queue.name = "Calls for #{t.to_s}"
    @queue.queue_date = t
    @queue.user = User.find(params[:user_id])
    @queue.leads = get_leads_for_queue
    save_queue(@queue)
  end

  # POST /queues
  # POST /queues.xml
  def create
    @queue = CallQueue.new(params[:queue])
    @queue.user = User.find(params[:user_id])
    @queue.leads = get_leads_for_queue
    save_queue(@queue)
  end

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
  
  protected
    def get_leads_for_queue(user=current_user, date=Date.today, size=200)
      default_sort = lambda{ |f,l| f.updated_at <=> l.updated_at }
      
      # order:
      #  1. hot: presented < today and not updated b/t presentation_date & now
      #  2. stale: enqueued < today and status == :queued
      #  3. new: top n where status == :assigned, for n = size - (presented.count + stale.count)
      # combine hot + stale + new      
      # hot_leads = Lead.hot.owned_by(user).sort(&default_sort)
      # stale_leads = Lead.stale.owned_by(user).sort(&default_sort) - hot_leads
      # priority_leads = (hot_leads + stale_leads).uniq
      # num_new_leads = size - priority_leads.count
      # new_leads = (Lead.open.owned_by(user).sort(&default_sort) - priority_leads)[0..(num_new_leads-1)]
      # priority_leads + new_leads
      
      # temporary:
      Lead.queued.owned_by(user)[0..(size-1)]
    end
    
    def save_queue(queue)
      respond_to do |format|
        if queue.save
          flash[:notice] = 'Call Queue was successfully created.'
          format.html { 
            redirect_to user_call_queue_lead_url(current_user, queue.id, queue.leads.first)
          }
          format.xml  { render :xml => queue, :status => :created, :location => queue }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => queue.errors, :status => :unprocessable_entity }
        end
      end
    end
end
