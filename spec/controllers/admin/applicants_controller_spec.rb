require File.join(Rails.root, 'spec', 'spec_helper')

describe Admin::ApplicantsController do
  before :each do
    @admin = login_as :admin
  end
  
  describe "if trying to onboard an applicant" do
    before :each do      
      @applicant = mock_model(Applicant)
      @user = mock_user :any
      @employee = @user.employee
      @applicant_id = @applicant.id.to_s
      @post_params = { :id => @applicant_id, :hired_at => Time.now }
      
      Applicant.stub!(:find).with(@applicant_id).and_return(@applicant)
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
end