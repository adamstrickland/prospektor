require 'spec_helper'

describe Employee do
  before :each do
    @zaphod = Employee.make(:first_name => 'Zaphod', :last_name => 'Beeblebrox')
  end
  
  it "should create a user from Zaphod" do
    @user = @zaphod.create_user
    
    @user.employee.should be(@zaphod)
    @user.login.should eql('zbeeblebrox')
    @user.email.should eql(@zaphod.email_name)
  end
end