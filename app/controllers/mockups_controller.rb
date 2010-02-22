require 'faker'

class MockupsController < ApplicationController
  skip_before_filter :login_required
  layout 'gemcutter'
  
  def index
  end

end
