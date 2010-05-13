require 'spec_helper'
require 'json_matcher'

describe VideosController do
  before do
    @key = '987IUY9876iuh'
  end
  
  describe "show is a two-step process; the html request sets up the player, the json request gets the flash file and other info" do
    before :each do
      @video_id = 123
      @video = mock_model(Video)
      @video.stub(:id).and_return(123)
      Video.stub(:find).and_return(@video)
    end
    
    describe "html step" do
      it "should render the player" do
        name = "Some Big Foo"
        @video.should_receive(:name).and_return(name)
        @user = mock_user :any
        @lead = mock_model(Lead)
        Lead.stub(:find).with(any_args()).and_return(@lead)
        get :show, :id => @video_id, :lead_id => @lead.id, :user_id => @user.id
        assigns[:title].should eql name
        response.should render_template('videos/player.html.haml')
      end
    end
    
    describe "json step" do
      before :each do
        @page_url = "#{Faker::Internet.domain_name}/videos/42"
        @callback_url = "#{Faker::Internet.domain_name}/cb"
        @callback_method = 'post'
        @swf_url = "#{Faker::Internet.domain_name}/vid.swf"
      end
      
      it "should return the swf info" do
        # @video.should_receive(:url).and_return(@page_url)
        @video.should_receive(:video_url).and_return(@swf_url)
        @video.should_receive(:callback_url).and_return(@callback_url)
        @video.should_receive(:callback_method).and_return(@callback_method)
        @user = mock_user :any
        @lead = mock_model(Lead)
        Lead.stub(:find).with(any_args()).and_return(@lead)
        get :show, :id => @video_id, :format => 'json', :lead_id => @lead.id, :user_id => @user.id
        assigns[:bindings][:lead_id].should eql @lead.id
        assigns[:bindings][:user_id].should eql @user.id
        response.should be_json_like({:callback => { :url => @callback_url, :method => @callback_method}, :swf => @swf_url})
      end
    end
    
    describe "the optional callback step" do
    end
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