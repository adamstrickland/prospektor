require 'spec_helper'

describe VideoTopic do
  before(:each) do
    @video = stub_model(Video)
    @valid_attributes = {
      :name => Faker::Lorem.words(2).join(' ').titleize,
      :video => @video
    }
  end

  it "should create a new instance given valid attributes" do
    VideoTopic.create!(@valid_attributes)
  end
end