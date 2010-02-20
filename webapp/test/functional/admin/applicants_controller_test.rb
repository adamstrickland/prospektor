require 'test_helper'

class Admin::ApplicantsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_applicants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create applicant" do
    assert_difference('Admin::Applicant.count') do
      post :create, :applicant => { }
    end

    assert_redirected_to applicant_path(assigns(:applicant))
  end

  test "should show applicant" do
    get :show, :id => admin_applicants(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_applicants(:one).to_param
    assert_response :success
  end

  test "should update applicant" do
    put :update, :id => admin_applicants(:one).to_param, :applicant => { }
    assert_redirected_to applicant_path(assigns(:applicant))
  end

  test "should destroy applicant" do
    assert_difference('Admin::Applicant.count', -1) do
      delete :destroy, :id => admin_applicants(:one).to_param
    end

    assert_redirected_to admin_applicants_path
  end
end
