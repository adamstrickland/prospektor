require 'chronic'

class DispositionController < ApplicationController
  def new
    @lead = Lead.find(params[:lead_id])
    @disposition_options = LeadStatus.all.reject{|s| ['CB', 'CLIENT', 'INV', 'VM'].include?(s.code)}.map{|s| ["#{s.code} - #{s.description}", s.code] }
    respond_to do |format|
      format.html { render 'new', :layout => 'modal' }
    end
  end

  def create
    respond_to do |format|
      @lead = Lead.find(params[:lead_id])
      if @lead.disposition!(current_user, params)
        format.json{ head :ok }
      else
        format.json{ render :json => @lead.errors, :status => :unprocessable_entity }
      end
    end
  end
end
