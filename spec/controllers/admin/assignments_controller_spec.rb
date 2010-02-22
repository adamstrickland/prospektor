require File.join(Rails.root, 'spec', 'spec_helper')

describe Admin::AssignmentsController do
  before :each do
    login_as :admin
    @state = 'TX'
    @users_home_state = State.find_by_state(@state)
    @states_in_timezone = @users_home_state.time_zone.states
    @other_states_in_timezone = @states_in_timezone.reject{|s| s.state == @users_home_state.state}
    @amount_in_each_state = 5
    @assignment_size = @amount_in_each_state * 2
  end
  
  describe "if assigning some leads," do
    before :each do
      @employee = mock_model(Employee)
      @employee.should_receive(:state_or_province).and_return(@state)
      
      @user = mock_model(User)
      @user_id = @user.id.to_s
      User.should_receive(:find).with(@user_id).and_return(@user)
      @user.should_receive(:employee).and_return(@employee)
      @user.stub!(:leads).and_return([])
      @user.stub!(:save).and_return(true)
    end
    
    describe "if there are leads in the user's state," do      
        # block_size = params[:size].to_i || 500
        # user = User.find(params[:user_id])
        # emp_state = user.employee.state_or_province
        # state_leads = Lead.valid.open.located_in_state_of(emp_state)
        # possible_leads = state_leads.count < block_size ? Lead.valid.open.located_in_timezone_of(emp_state) : state_leads
        # assignments = possible_leads[0..(block_size - 1)]
        # user.leads << assignments

      before :each do
        @amount_in_each_state.times{ Lead.make(:state => @users_home_state) }
        
        @leads = (1..@amount_in_each_state).map{ mock_model(Lead) }
        
        Lead.should_receive(:valid).at_least(:once).and_return(Lead)
        Lead.should_receive(:open).at_least(:once).and_return(Lead)
        Lead.should_receive(:located_in_state_of).with(@state).and_return(@leads)
      end  
        
      it "if enough leads are in the user's state, they should be assigned" do
        @assignment_size = 5
        post :create, :size => @assignment_size, :user_id => @user_id, :format => 'json'
        # puts response.body
      
        response.should be_json_like(:assignments => @amount_in_each_state)
      end
      
      it "if there are leads in the user's state's timezone, assign as many as possible, then assign from timzone" do
        # @other_states_in_timezone.each do |st|
        #   @amount_in_each_state.times do
        #     Lead.make(:state  => st)
        #   end
        # end
        @more_leads = @leads + (1..@amount_in_each_state).map{ mock_model(Lead) }
        @more_leads.should have(@assignment_size).items
        Lead.should_receive(:located_in_timezone_of).with(@state).and_return(@more_leads)
        post :create, :size => @assignment_size, :user_id => @user_id, :format => 'json'
        response.should be_json_like(:assignments => @assignment_size)
      end
      
      it "if there are not leads in the user's state's timezone, only assign from home state" do
        # @assignment_size = 5
        # @all_states = State.all
        # @all_states.reject{|s| @states_in_timezone.include?(s)}.each do |s|
        #   @amount_in_each_state.times{ Lead.make(:state => s) }
        # end
        Lead.should_receive(:located_in_timezone_of).with(@state).and_return(@leads)
        post :create, :size => @assignment_size, :user_id => @user_id, :format => 'json'
        response.should be_json_like(:assignments => @amount_in_each_state)
      end
    end
    
    it "should do anything if not json" do
      post :create, :size => @block_size, :user_id => @user_id, :format => 'html'
      response.should_not be_success
    end
  end
end