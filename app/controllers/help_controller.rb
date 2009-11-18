class HelpController < ApplicationController
  def pdf
    asset_name = params[:asset]
    render :file => "/help/#{asset_name}.pdf", :content_type => 'application/pdf'
  end
  
  def quick_start
    render :inline => 'This is the Quick Start'
  end
  
  def users_guide
    render :inline => "This is the User's Guide"
  end
  
  def documentation
    render :inline => 'This is the Documentation'
  end
end
