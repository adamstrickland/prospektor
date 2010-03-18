require 'spec_helper'

describe 'page at' do
  before :each do
    @user = login_as :any
  end
  
  describe '/dashboard' do
    it 'renders the dashboard' do
      render '/dashboard/index.html.haml'
      response.should have_text /Dashboard/
    end
    # it 'renders the dashboard' do
    #   render '/dashboard/index.html.haml'
    #   response.should have_text /Around the Corner/
    # end
    
    it 'renders the first_time' do
      render '/dashboard/getting_started.html.haml'
      response.should have_text /Welcome/
    end
    # it 'renders the first_time' do
    #   render '/dashboard/first_time.html.haml'
    #   response.should have_text /Getting Started/
    # end
  end
  
  describe '/terms' do  
    it 'renders the nda' do
      # template.should_receive(:render).with(:partial => 'confidentiality_agreement')
      render '/dashboard/nda.html.haml'
    end
  end
end