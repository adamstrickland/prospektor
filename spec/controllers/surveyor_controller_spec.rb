require 'spec_helper'

describe SurveyorController do
  before do
    @survey_code = 'bcr'
    @response_code = 'ABCDE'
    @survey = mock_model(Survey)
    Survey.stub!(:find_by_access_code).with(@survey_code).and_return(@survey)
    @survey.stub!(:access_code).and_return(@survey_code)
    @response_set = mock_model(ResponseSet)
    ResponseSet.stub!(:create).with(any_args()).and_return(@response_set)
    @response_set.stub!(:access_code).and_return(@response_code)
  end
  
  describe "anyone," do
    describe "using the surveyor mechanism," do
      it "the survey is displayed" do
        post :create, :survey_code => @survey_code
        response.should redirect_to edit_my_survey_path(:survey_code => @survey_code, :response_set_code  => @response_code)
      end
    end
    
    describe "if the autotake page is used," do
      before do
      end
      
      describe "and a key is sent (if no key is sent, is same as default)," do
        before do
          @key = 'QWERTY'
          @lead = mock_model(Lead)
          Lead.should_receive(:find_by_key).with(@key).and_return(@lead)
          
          ResponseSet.stub!(:find_by_access_code).with(@response_code).and_return(@response_set)
          @response_set.should_receive(:lead_id?).and_return(false)
          @response_set.should_receive(:lead_id=).with(@lead)
          @response_set.should_receive(:save).and_return(true)
        end
        
        it "the response should be associated to the lead" do
          post :create, :survey_code => @survey_code, :key => @key
          response.should redirect_to edit_my_survey_path(:survey_code => @survey_code, :response_set_code  => @response_code)
        end
      end
    end
    
    describe "if they use a static url," do
      before do
      end
      
      it "the autotake is renderd (which should take them to the survey itself)" do
        get :get_bcr, :key => @key
        response.should render_template 'surveyor/autotake.html.haml'
      end
    end
  end
end