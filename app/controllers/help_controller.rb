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
    @entries = {
      'Presentations' => {
        "BCR Presentation" => '#'
      },
      'Videos' => {
        'BCR Presentation Training' => 'http://www.trigonsolutions.com/SalesAides/BCR Presentation Training Video/BCR Presentation Training Video.swf'
      }
    }
  end
  
  def training_videos
  end
end
