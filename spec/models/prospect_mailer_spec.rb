require 'spec_helper'

describe ProspectMailer do
  before :each do
  end
  
  describe "sends a information email" do
    before :each do
      @presentation = mock_model(Presentation)
      @user = mock_user
      @user.should_receive(:official_phone).and_return(Faker::PhoneNumber.phone_number)
      @topic = mock_model(Topic)
      @lead = stub_model(Lead)
      @topic.should_receive(:name).any_number_of_times.and_return("Jumpin' Jehosephat!")
      @presentation.should_receive(:user).any_number_of_times.and_return(@user)
      @presentation.should_receive(:topic).any_number_of_times.and_return(@topic)
      @presentation.should_receive(:email).any_number_of_times.and_return(Faker::Internet.email)
      @presentation.should_receive(:url).and_return("http://#{Faker::Internet.domain_name}/some/obscure/path")
      @presentation.should_receive(:lead).any_number_of_times.and_return(@lead)
      @email = ProspectMailer.create_presentation_invitation(@presentation)
    end
    
    it "should have a reply-to to the user's email addy'" do
      @email.reply_to.should include @user.email
    end
  end
end
