require 'spec_helper'

describe 'page at' do
  before :each do
    @user = login_as :any
    @lead = mock_model(Lead)
  end
  
  describe '/leads/:id/disposition' do
    before :each do
      @disposition_options = [['Test', 1]]
    end
    
    it 'renders the new dispo form' do
      assigns[:lead] = @lead
      assigns[:disposition_options] = @disposition_options
      render 'disposition/new.html.haml'
      response.should have_text /Call Back/
    end
  end
end