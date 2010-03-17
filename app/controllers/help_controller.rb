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
    # Just scrape http://www.trigonsolutions.com/Sales%20Aides.htm ???
    @www_root = 'http://www.trigonsolutions.com'
    @www_sa = "#{@www_root}/SalesAides"
    @entries = {
      'Expert Services' => {
        "Presentation" => "#{@www_sa}/BCR_Presentation.htm",
        'BCR Presentation Training' => "#{@www_sa}/BCR Presentation Training Video/BCR Presentation Training Video.swf",
      },
      'Analytical Services' => {
        'Presentation' => "#{@www_sa}/ACS Presentation.htm",
        'Keys to Your Success' => "#{@www_sa}/7-Step Program.htm",
        'Sales Problem Identifier' => "#{@www_sa}/Sales Problem Identifier.htm",
        'Meeting Resistances' => "#{@www_sa}/Resistances.htm",
        'Power Closes' => "#{@www_sa}/Power Closes.htm",
        'Creating Pain' => "#{@www_sa}/Creating Pain.htm",
      },
    }
    
    # doc = Nokogiri::HTML(open("#{www_root}/Sales%20Aides.htm"))
    # 
    # #sections
    # doc.search('table table table td').search('b>font[size="3"],font[size="3"]>b').each do |sec|
    # end
  end
  
  def training_videos
  end
end
