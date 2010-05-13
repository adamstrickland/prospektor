require 'cgi'

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
    @bindings = {}.merge(params)
    respond_to do |format|
      format.html do
        @title = @video.name
        @video_json_url = CGI.unescapeHTML(video_url(@video, {:format => 'json'}.merge(@bindings)))
        render :action => 'player'
      end
      format.json do
        # LeadEvent.opened_video(Lead.find(@bindings[:lead_id]), User.find(@bindings[:user_id]), @video)
        hash = {
          :swf => h(@video.video_url(@bindings)),
          :callback => {
            :url => h(@video.callback_url(@bindings)),
            :method => @video.callback_method
          }
        }
        render :json => hash, :status => :ok
      end
    end
  end
  
  def index
    @videos = Video.all
    render :action => 'index', :layout => 'public'
  end
end
