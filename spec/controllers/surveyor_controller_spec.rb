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
    describe "if they want to use the plugin's default mechanism," do
      it "should be able to get to the BCR survey" do
        post :create, :survey_code => @survey_code
        response.should redirect_to edit_my_survey_path(:survey_code => @survey_code, :response_set_code  => @response_code)
        # response.should have_text('BCR')
      end
    end
    
    describe "if they want to use the url from, for instance, an email," do
      it "should be able to get to the BCR survey" # do
      #         get :bcr
      #         response.should redirect_to edit_my_survey_url(:survey_code => @survey_code, :response_set_code  => @response_code)
      #         # response.should have_text('BCR')
      #       end
    end
  end
end