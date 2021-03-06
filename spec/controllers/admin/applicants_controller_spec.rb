require File.join(Rails.root, 'spec', 'spec_helper')

describe Admin::ApplicantsController do
  before :each do
    @admin = login_as :admin
    @applicant = mock_model(Applicant)
    @applicant_id = @applicant.id.to_s
    Applicant.stub!(:find).with(@applicant_id).and_return(@applicant)
  end
  
  describe "if trying to onboard an applicant" do
    before :each do
      @user = mock_user :any
      @employee = @user.employee
      @post_params = { :id => @applicant_id, :hired_at => Time.now }
    end
    
    it "should be a one click op" do
      @applicant.should_receive(:create_employee).and_return(@employee)
      @employee.should_receive(:create_user).and_return(@user)
      @employee.should_receive(:save).and_return(true)
      @user.should_receive(:save).and_return(true)
      @user.stub!(:login).and_return('zbeeblebrox')
      @employee.stub!(:full_name).and_return('Zaphod Beeblebrox')
      
      post :onboard, {:format => 'json'}.merge(@post_params)
      response.should be_json_like({ :status => :ok, :user => { :login => @user.login, :name => @employee.full_name } })
    end
  
    it "shouldn't do anything for an html post" do
      post :onboard, {:format => 'html'}.merge(@post_params)
      response.should_not be_success
    end
  end
  
  describe "should reject an applicant" do
    it "should be one-click" do
      @applicant.should_receive(:rejected=).with(true)
      @applicant.should_receive(:save).and_return(true)
      post :reject, :format => 'json', :id => @applicant_id
    end
  end
end