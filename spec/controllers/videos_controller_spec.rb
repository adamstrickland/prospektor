require 'spec_helper'
require 'json_matcher'

describe VideosController do
  before do
    @key = '987IUY9876iuh'
  end
  
  describe "when requesting bcr" do
    it "should render the player" do
      get :bcr
      assigns[:title].should eql('Business Condition Review')
      response.should render_template('videos/player.html.haml')
    end
    
    describe "should return data when using .json" do
      before :each do
        @expect = { :swf => "http://localhost:3000/bad_grin.swf" }
        @redirect_base_url = "http://localhost:3000/public/bcr?key="
      end
      
      it "with a key" do
        get :bcr, :format => 'json', :key => @key
        response.should be_json_like({:redirect => "#{@redirect_base_url}#{@key}"}.merge(@expect))
      end
      
      it "without a key" do
        get :bcr, :format => 'json'
        response.should be_json_like({:redirect => @redirect_base_url}.merge(@expect))
      end
    end
    
    it "should have a key when the key is supplied" do
      get :bcr, :key => @key
      response.should render_template('videos/player.html.haml')
    end
  end
end