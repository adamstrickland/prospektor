require 'spec_helper'

describe Presentation do
  shared_examples_for "all topics" do
    it "should be valid with all attributes" do
      Presentation.new(@params).should be_valid
    end
  
    it "should require a lead" do
      Presentation.new(@params.merge({:lead => nil})).should_not be_valid
    end
  
    it "should require a user" do
      Presentation.new(@params.merge({:user => nil})).should_not be_valid
    end
  
    it "should require a topic" do
      Presentation.new(@params.merge({:topic => nil})).should_not be_valid
    end

    it "should require a url" do
      Presentation.new(@params.merge({:url => nil})).should_not be_valid
      Presentation.new(@params.merge({:url => ""})).should_not be_valid
    end

    it "should require an email" do
      Presentation.new(@params.merge({:email => nil})).should_not be_valid
      Presentation.new(@params.merge({:email => ""})).should_not be_valid
      Presentation.new(@params.merge({:email => "blahbityblach"})).should_not be_valid
    end
  
    it "should create an event on a good save" do
      lambda{
        Presentation.new(@params).save!
      }.should change(LeadEvent, :count).by(1)
    end
  end
  
  describe "using an info topic" do
    before :each do
      @params = {
        :lead => Lead.make,
        :user => User.make(:employee => Employee.make),
        :email => Faker::Internet.email,
        :topic => InformationTopic.make,
        :url => "#{Faker::Internet.domain_name}/#{Faker::Internet.domain_word}",
      }
    end
    
    it_should_behave_like "all topics"
  end
  
  describe "using a video topic" do
    before :each do
      @video_topic = VideoTopic.make
      @params = {
        :lead => Lead.make,
        :user => User.make(:employee => Employee.make),
        :email => Faker::Internet.email,
        :topic => @video_topic,
        :url => @video_topic.url
      }
    end
    
    it_should_behave_like "all topics"
  end
end