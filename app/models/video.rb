require 'erubis'

class Video < ActiveRecord::Base
  alias_attribute :callback_method, :on_complete_callback_method
    
  def page_url(bindings={})
    emit_url(self.url_template, bindings)
  end
  alias_method :url, :page_url
  
  def callback_url(bindings={})
    emit_url(self.on_complete_callback_template, bindings)
  end
  
  def video_url(bindings={})
    emit_url(self.video_url_template, bindings)
  end
  
  private
    def emit_url(base_url, bindings={})
      emitted = Erubis::FastEruby.new(base_url).evaluate({ :id => self.id }.merge(bindings))
      # if emitted.index('/') == 0
      # else
      # end
      emitted
    end
end
