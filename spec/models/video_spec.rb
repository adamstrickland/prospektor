require 'spec_helper'

describe Video do
  before(:each) do
    @valid_attributes = {
      :name => Faker::Lorem.words(2).join(' ').titleize,
      :url_template => "#{Faker::Internet.domain_name}/#{Faker::Internet.domain_word}"
    }
  end

  it "should create a new instance given valid attributes" do
    Video.create!(@valid_attributes)
  end
  
  describe "generated url" do
    before :each do
      @base_url = "#{Faker::Internet.domain_name}?key="
      @template_url = "#{@base_url}<%= @key %>"
      @video = Video.make(:url_template => @template_url )
      @key = "ABC123"
      @key_params = { :key => @key }
      @complete_url = "#{@base_url}#{@key}"
    end
    
    it "should be plain when no bindings provided" do
      @video.url.should eql @base_url
    end
    
    it "should have the params provided if they're in the template'" do
      @video.url(@key_params).should eql @complete_url
    end
    
    it "should ignore any params provided that aren't in the template'" do
      foo_params = { :foo => 'FOO' }
      @video.url(foo_params).should eql @base_url
      @video.url(foo_params.merge(@key_params)).should eql @complete_url
    end
  end
end
