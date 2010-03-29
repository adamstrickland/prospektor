require 'spec_helper'

describe ApplicantObserver do
  before :each do
    @applicant = Applicant.make_unsaved
  end
  
  describe "should try to deliver an email" do
    before :each do
      Notifier.should_receive(:deliver_new_applicant_alert).with(@applicant)
    end
    
    it "when the is created" do
      @applicant.save
    end
  end  
end