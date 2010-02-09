require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Question, "when creating a new question" do
  before(:each) do
    @ss = mock_model(SurveySection)
    @question = Question.new(:text => "What is your favorite color?", :survey_section => @ss, :is_mandatory => true, :display_order => 1)
  end

  it "should be valid" do
    @question.should be_valid
  end

  it "should be invalid without text" do
    @question.text = nil
    @question.should have(1).error_on(:text)
  end
    
  it "should have a parent survey section" do
    @question.survey_section = nil
    @question.should have(1).error_on(:survey_section_id)
  end
    
  it "should be mandatory by default" do
    @question.mandatory?.should be_true
  end
  
end

describe Question, "that has answers" do
  before(:each) do
    @question = Factory(:question, :text => "What is your favorite color?")
    Factory(:answer, :question => @question, :display_order => 3, :text => "blue")
    Factory(:answer, :question => @question, :display_order => 1, :text => "red")
    Factory(:answer, :question => @question, :display_order => 2, :text => "green")
  end
  
  it "should have answers" do
    @question.answers.should have(3).answers
  end
  
  it "should retrieve those answers in display_order" do
    @question.answers.map(&:display_order).should == [1,2,3]
  end
  
end

describe Question, "when interacting with an instance" do
  
  before(:each) do
    @ss = mock_model(SurveySection)
    @question = Question.new(:text => "What is your favorite color?", :survey_section => @ss)
  end

  it "should return 'default' for nil display type" do
    @question.display_type = nil
    @question.renderer.should == :default
  end
  
end

describe Question, "with dependencies" do
  before(:each) do
    @ss = mock_model(SurveySection)
    @rs = mock_model(ResponseSet)
    @question = Question.new(:text => "Which island?", :survey_section => @ss)
  end

  it "should check its dependency" do
    @dependency = mock_model(Dependency)
    @dependency.stub!(:is_met?).with(@rs).and_return(true)
    @question.stub!(:dependency).and_return(@dependency)
    @question.triggered?(@rs).should == true
  end
  
end
