require 'test_helper'

class LeadsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lead" do
    assert_difference('Lead.count') do
      post :create, :lead => { }
    end

    assert_redirected_to lead_path(assigns(:lead))
  end

  test "should show lead" do
    get :show, :id => leads(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => leads(:one).to_param
    assert_response :success
  end

  test "should update lead" do
    put :update, :id => leads(:one).to_param, :lead => { }
    assert_redirected_to lead_path(assigns(:lead))
  end

  test "should destroy lead" do
    assert_difference('Lead.count', -1) do
      delete :destroy, :id => leads(:one).to_param
    end

    assert_redirected_to leads_path
  end
end
