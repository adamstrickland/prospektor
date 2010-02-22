require 'spec_helper'

describe Applicant do
  before :each do
    @applicant = Applicant.make
  end
  
  it "should create an employee with today as the hire date" do
    @employee = @applicant.create_employee
    [:first_name, :middle_initial, :last_name, :preferred_name, :address, :city, :postal_code, :country, :business_phone].each do |attrib|
      @employee.send(attrib).should eql(@applicant.send(attrib))
    end
    @employee.gender.should eql('M')
    @employee.title.should eql('Sales')
    @employee.department_name.should eql('ES')
    @employee.state_or_province.should eql(@applicant.state_province)
    @employee.phone.should eql(@applicant.home_phone)
    @employee.cellular.should eql(@applicant.mobile_phone)
    @employee.status_change_date.gmtime.should eql(Date.today.to_time.gmtime)
    @employee.date_hired.gmtime.should eql(Date.today.to_time.gmtime)
    @employee.active?.should eql(true)
  end
end