require 'test_helper'

class TouchpointsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:touchpoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create touchpoint" do
    assert_difference('Touchpoint.count') do
      post :create, :touchpoint => { }
    end

    assert_redirected_to touchpoint_path(assigns(:touchpoint))
  end

  test "should show touchpoint" do
    get :show, :id => touchpoints(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => touchpoints(:one).to_param
    assert_response :success
  end

  test "should update touchpoint" do
    put :update, :id => touchpoints(:one).to_param, :touchpoint => { }
    assert_redirected_to touchpoint_path(assigns(:touchpoint))
  end

  test "should destroy touchpoint" do
    assert_difference('Touchpoint.count', -1) do
      delete :destroy, :id => touchpoints(:one).to_param
    end

    assert_redirected_to touchpoints_path
  end
end
