require 'faker'

class MockupsController < ApplicationController
  skip_before_filter :login_required
  layout 'gemcutter'
  
  def index
  end
  
  def show
    @lead = Lead.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
end
