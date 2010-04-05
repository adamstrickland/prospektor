require 'spec_helper'

describe Notifier do
  # include ActionMailerSpecSettings
  
  before :each do
    # default_url_options[:host] = request.host
    # Notifier.send(:default_url_options=, { :host => "localhost.test" })
  end
  
  describe "a booked sale email" do
    before :each do
      @lead = mock_model(Lead)
      @user = mock_user
      @employee = @user.employee
      @employee.stub!(:full_name).and_return('Donald Duck')
      @lead.should_receive(:owner).any_number_of_times.and_return(@user)
      @lead.should_receive(:full_name).and_return('Scrooge McDuck')
      @lead.should_receive(:company).and_return('Duck Enterprises')
      @lead.should_receive(:phone).and_return('8888675309')
    end
    
    it "should render the booked sale email" do
      @lead.should_receive(:comments).and_return([])
      @email = Notifier.create_booked_sale(@lead)
      @email.subject.should eql('Sale Pending')
      @email.to.should eql(['acs-scheduling@trigonsolutions.com'])
      @email.from.should eql(['system@trigonsolutions.com'])
      @email.body.should match /^.*Sold By: Donald Duck.*$/
      @email.body.should match /^.*Customer: Scrooge McDuck.*$/
    end
    
    it "should have comments if the lead has comments" do
      comment_text = 'These guys are goofy'
      @comment = mock_model(Comment)
      @comment.should_receive(:user).and_return(@user)
      @comment.should_receive(:comment).and_return(comment_text)
      @comment.should_receive(:updated_at).and_return(1.days.ago)
      @lead.should_receive(:comments).and_return([@comment])
      @email = Notifier.create_booked_sale(@lead)
      @email.body.should match /^.*#{comment_text}.*$/
    end
  end
  
  describe "should render the snoop alert email" do
    before :each do
      @user = mock_user
      @user.stub!(:login).and_return('dduck')
    end
    
    after :each do
      @email.subject.should eql('Snoop Alert!')
      @email.to.should eql(['prospektor-admin@trigonsolutions.com'])
      @email.from.should eql(['Prospektor'])
      @email.body.should match /^.*Snooper: #{@user.login}.*$/
    end
    
    it "when invoked with a request object" do
      @request = { :foo => 'bar' }
      @email = Notifier.create_snoop_alert(@user, @request)
      @email.body.should match /^.*foo:.*/
      @email.body.should match /^.*bar.*$/
      # @email.body[:context][:foo].should eql('bar')
    end
    
    it "when invoked without a request object" do
      @email = Notifier.create_snoop_alert(@user)
      @email.body.should match /^.*None, sadly.  Burn the witch!!11!.*$/
      # @email.body[:context].should be_nil
    end
  end
  
  it "should render a new applicant alert email" do
    @applicant = mock_model(Applicant)
    name = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
    @applicant.should_receive(:full_name).and_return(name)
    [:home_phone, :business_phone, :mobile_phone, :city, :state_province].each do |a|
      @applicant.should_receive(a).and_return(Faker::Lorem.words(1))
    end
    @email = Notifier.create_new_applicant_alert(@applicant)
    @email.subject.should eql('New Applicant')
    @email.to.should eql(['hr@trigonsolutions.com'])
    @email.from.should eql(['Prospektor'])
    @email.body.should match /^.*Full Name: #{name}.*$/
    # @email.body[:applicant].should eql(@applicant)
  end
end