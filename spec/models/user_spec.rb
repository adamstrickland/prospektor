require 'spec_helper'

# has_and_belongs_to_many :roles
# has_and_belongs_to_many :leads
# alias_attribute :assignments, :leads
# has_many :presentations
# has_many :appointments
# has_many :events
# has_many :comments
# has_many :call_queues
# belongs_to :employee
# validates_length_of :phone, :maximum => 10
# validates_length_of :mobile, :maximum => 10, :allow_nil => true

# def is_admin?
# def official_phone
# def callbacks
# def login=(value)
# def email=(value)
# def ready_leads(amount=0)
# def name
# def self.generate_password(size=8)

describe User do
  before :each do
    @leads = (1..5).map{ 
      l = mock_model(Lead)
      l.stub!(:destroyed?).and_return(false)
      l.stub!(:quoted_id).and_return(l.id.to_s)
      # l.stub!(:employee_id).and_return(true)
      l.stub!(:has_attribute?).with(anything()).and_return(true)
      l.stub!(:[]).with(anything()).and_return([])
      l
    }
    @user = User.make
    @user.leads = @leads
    @user.leads.should have(@leads.count).items
  end

  it "should always have a lower-case login" do
    login = 'ASMITH'
    @user.login = login
    @user.login.should eql(login.downcase)
  end

  it "should always have a lower-case email address" do
    email = 'ThisIsTheEnd@TheWorld.UK'
    @user.email = email
    @user.email.should eql(email.downcase)
  end

  it "should generate a random password" do
    pwd_size = 8
    10.times do
      pwd1 = User.generate_password(pwd_size)
      pwd1.length.should eql(pwd_size)
      pwd2 = User.generate_password
      pwd2.length.should eql(pwd_size)
      pwd1.should_not eql(pwd2)
    end
  end
  
  describe "should return a phone number" do
    before :each do
      @trigon = "214-361-0080"
      @user.phone = @trigon.gsub(/-/, "")
    end
    
    it "should be trigon's phone number" do
      @user.extension = nil
      @user.official_phone.should eql(@trigon)
    end
    
    it "should have their extension when available" do
      @user.extension = "1234"
      @user.official_phone.should eql("#{@trigon} x1234")
    end
  end
  
  describe "should indicate if the user is an admin" do
    before :each do
      # fixtures :roles
    end
    
    it "should be true if they have the admin role" do
      @user.roles << Role.find_by_title('admin')
      @user.roles.should have(1).items
      @user.is_admin?.should be_true
    end
    
    it "should be false if they don't have the admin role" do
      @user.is_admin?.should be_false
      @user.roles = Role.all.reject{|r| r.title == 'admin' }
      @user.is_admin?.should be_false
    end
  end
  
  describe "should return a list of leads" do
    before :each do
      @date = Date.today
      @leads.each_with_index{ |l,i|
        l.should_receive(:status).at_least(:once).and_return(nil)
      }
      @user.leads.select{|l| l.status.blank? }.should have(@leads.count).items
      @user.leads.select{|l| l.status.present? and l.status.state == 'assigned' }.should have(0).items
      
      @bad_leads = [@leads[2]]
      @good_leads = @leads[0..1] + @leads[3..-1]
    end
    
    it "when none of them has :updated_at.nil?" do
      @leads.each_with_index{ |l,i|
        l.should_receive(:updated_at).any_number_of_times.and_return(@date - i)
      }
      @user.leads.select{|l| l.updated_at.blank? }.should have(0).items
      @results = @user.ready_leads
      @results.should have(@leads.count).items
      @results[0].updated_at.should eql(@date - (@leads.count - 1))
      @results[-1].updated_at.should eql(@date)
    end

    it "when some of them has :updated_at.nil?" do
      @good_leads.each_with_index{ |l,i|
        l.should_receive(:updated_at).any_number_of_times.and_return(@date - i)
      }
      @bad_leads.each_with_index{ |l,i|
        l.should_receive(:updated_at).any_number_of_times.and_return(nil)
      }
      @user.leads.select{|l| l.updated_at.blank? }.should have(@bad_leads.count).items
      @user.leads.select{|l| l.updated_at.present? }.should have(@good_leads.count).items
      @results = @user.ready_leads
      @results.should have(@leads.count).items
      @results[0].updated_at.should eql(@good_leads.last.updated_at)
      @results[-2].updated_at.should eql(@good_leads.first.updated_at)
      @results[-1].updated_at.should eql(nil)
    end
  end
end