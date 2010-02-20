class ApplicantsController < ApplicationController
  skip_before_filter :login_required
  layout 'public', :only => [:new, :create, :thanks]
  
  def new
    @applicant = Applicant.new(:has_internet => false, :has_applied_before => false)
  end
  
  def create
    @applicant = Applicant.new(params[:applicant])
    if @applicant.save
      render :action => 'thanks'
    else
      render :action => 'new', :layout => 'public'
    end
  end
end