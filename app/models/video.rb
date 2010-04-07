require 'erubis'

class Video < ActiveRecord::Base
  def callback_url(bindings)
    Erubis::FastEruby.new(self.on_complete_hook).evaluate(bindings)
  end
end
