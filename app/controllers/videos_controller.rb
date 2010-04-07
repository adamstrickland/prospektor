class VideosController < ApplicationController
  layout 'player'
  skip_before_filter :login_required
  
  def bcr
    @key = params[:key]
    
    respond_to do |format|
      format.html do
        @title = 'Business Condition Review'
        render 'player'
      end
      format.json do
        # TODO: refactor to use a model here...  InfoTopic, maybe?
        if Rails.env == 'production'
          @video_url = 'http://www.trigonsolutions.com/videos/BCR200/BCR200.swf'
          @redirect_url = "http://sales.trigonsolutions.com/public/bcr?key=#{@key}"
        else
          @video_url = "http://localhost:3000/bad_grin.swf"
          @redirect_url = "http://localhost:3000/public/bcr?key=#{@key}"
        end
        
        render :json => { :swf => @video_url, :redirect => @redirect_url }, :status => :ok
      end
    end
  end
  
  def show
    @video = Video.find(params[:id])
    # @bindings = {
    #   :key => params[:key].present? ? params[:key] : Base64.encode64(Time.now.to_s).strip
    # }
    @bindings = params
    respond_to do |format|
      format.html do
        @title = @video.name
        render :action => 'player'
      end
      format.json do
        render :json => { :swf => @video.url, :callback => @video.callback_url(@bindings) }, :status => :ok
      end
    end
  end
end
