require 'spec_helper'

describe ApplicantObserver do
  include ObserverTestHelperMethods
  
  before :each do
    enable_observers
    @applicant = Applicant.make_unsaved
  end
  
  describe "should try to deliver an email" do
    before :each do
      Notifier.should_receive(:deliver_new_applicant_alert).at_least(:once).with(@applicant)
    end
    
    it "when the is created" do
      @applicant.save
    end
  end  
end