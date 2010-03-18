require 'spec_helper'

describe PresentationObserver do
  before :each do
    @preso = Presentation.make_unsaved(:url => "http://#{Faker::Internet.domain_name}")
    @preso.should be_valid
  end
  
  describe "should try to deliver an email" do
    before :each do
      ProspectMailer.should_receive(:deliver_presentation_invitation).with(@preso)
    end
    
    it "when after_create is invoked directly" do
      PresentationObserver.instance.after_create(@preso)
    end
    
    it "when the preso is saved" do
      @preso.save
    end
  end
  
  # it "should not send email if no scheduled date" do
  #   ProspectMailer.should_not_receive(:deliver_presentation_invitation).with(@preso)
  # end
end