require 'spec_helper'

describe Presentation do
  
  # belongs_to :lead
  # belongs_to :user
  # belongs_to :topic
  # 
  # after_save do |rec|
  #   LeadEvent.sent(rec.lead, rec.topic.name, rec.user, { :to => rec.email })
  # end
  # 
  # validates_presence_of :email, :url, :user, :lead, :topic
  # validates_email :email
  
  before :each do
    @params = {
      :lead => Lead.make,
      :user => User.make(:employee => Employee.make),
      :email => Faker::Internet.email,
      :topic => InformationTopic.make,
      :url => "#{Faker::Internet.domain_name}/#{Faker::Internet.domain_word}",
    }
  end
  
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