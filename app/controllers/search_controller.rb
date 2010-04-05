class SearchController < ApplicationController
  def index
    respond_to do |format|
      format.ajax do
        unless params[:search].blank?
          # @leads = Lead.paginate :page => params[:page] || 1, :per_page => 5, :conditions => Lead.conditions_by_like(params[:search], search_columns)
          options = {:page => params[:page] || 1, :per_page => 5}
          if current_user.is_admin?
            @leads = Lead.searchy(params[:search]).paginate(options)
          else
            @leads = current_user.leads.searchy(params[:search]).paginate(options)
          end
        end
        render :action => 'index', :layout => false
      end
    end
  end
  
  def new
    respond_to do |format|
      format.ajax do
        render :action => 'new', :layout => false
      end
    end
  end
end
