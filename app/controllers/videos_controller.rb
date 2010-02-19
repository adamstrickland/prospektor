class VideosController < ApplicationController
  layout 'player'
  skip_before_filter :login_required
  
  def bcr
    @key = params[:key]
    @video_url = "http://localhost:3000/bad_grin.swf" # 'http://www.trigonsolutions.com/videos/BCR200/BCR200.swf'
    @redirect_url = "http://localhost:3000/public/bcr?key=#{@key}"
    respond_to do |format|
      format.html do
      end
      format.json do
        render :json => { :swf => @video_url, :redirect => @redirect_url }, :status => :ok
      end
    end
  end
end
