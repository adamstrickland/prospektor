class CommentsController < ApplicationController
  # # GET /comments
  # # GET /comments.xml
  # def index
  #   @comments = Comment.all
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @comments }
  #   end
  # end
  # 
  # # GET /comments/1
  # # GET /comments/1.xml
  # def show
  #   @comment = Comment.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @comment }
  #   end
  # end
  
  def index
    @comments = Lead.find(params[:lead_id]).comments.reject{|c| c.comment.blank? }.sort_by{|c| c.created_at }.reverse
    render :partial => 'index'
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
    @lead = Lead.find(params[:lead_id])

    respond_to do |format|
      format.html { render 'new', :layout => 'modal' }
      format.xml  { render :xml => @comment }
    end
  end

  # # GET /comments/1/edit
  # def edit
  #   @comment = Comment.find(params[:id])
  # end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.lead = Lead.find(params[:lead_id])

    respond_to do |format|
      if @comment.save
        format.json{
          render :json => { :status => :success }
        }
      else
        format.json{
          render :json => { :status => :failure, :errors => @comment.errors }
        }
      end
      # if @comment.save
      #   format.html { render :partial => 'events/listing_item', :locals => { :event => @comment.event } }
      # else
      #   format.html { render :partial => 'common/errors', :status => :unprocessable_entity, :locals => { :errors => @comment.errors } }
      # end
      #   flash[:notice] = 'Comment was successfully created.'
      #   format.html { redirect_to(@comment) }
      #   format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      # else
      #   format.html { render :action => "new" }
      #   format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      # end
    end
  end

  # # PUT /comments/1
  # # PUT /comments/1.xml
  # def update
  #   @comment = Comment.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @comment.update_attributes(params[:comment])
  #       flash[:notice] = 'Comment was successfully updated.'
  #       format.html { redirect_to(@comment) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # DELETE /comments/1
  # # DELETE /comments/1.xml
  # def destroy
  #   @comment = Comment.find(params[:id])
  #   @comment.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(comments_url) }
  #     format.xml  { head :ok }
  #   end
  # end
end
