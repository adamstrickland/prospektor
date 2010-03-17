require 'nokogiri'
require 'open-uri'

class HelpController < ApplicationController
  layout false
  def pdf
    asset_name = params[:asset]
    render :file => "/help/#{asset_name}.pdf", :content_type => 'application/pdf'
  end
  
  def quick_start
    render :inline => 'This is the Quick Start'
  end
  
  def documentation
    render :inline => 'This is the Documentation'
  end
  
  def sales_aides
    @website_root_url = 'http://www.trigonsolutions.com'
    @sales_aides_root_url = "#{@website_root_url}/SalesAides"
    
    # doc = Nokogiri::HTML(open("#{@website_root_url}/Sales%20Aides.htm"))
    # doc.search('table table table td p a')
  end
  
  def training_videos
  end
end
