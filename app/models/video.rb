require 'erubis'

class Video < ActiveRecord::Base
  alias_attribute :callback_method, :on_complete_callback_method
    
  def video_url(bindings={})
    emit_url(self.url_template, bindings)
  end
  alias_method :url, :video_url
  
  def callback_url(bindings={})
    emit_url(self.on_complete_callback_template, bindings)
  end
  
  private
    def emit_url(base_url, bindings={})
      Erubis::FastEruby.new(base_url).evaluate(bindings)
    end
end
