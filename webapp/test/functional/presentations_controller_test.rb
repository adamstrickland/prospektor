require 'test_helper'

class PresentationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:presentations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create presentation" do
    assert_difference('Presentation.count') do
      post :create, :presentation => { }
    end

    assert_redirected_to presentation_path(assigns(:presentation))
  end

  test "should show presentation" do
    get :show, :id => presentations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => presentations(:one).to_param
    assert_response :success
  end

  test "should update presentation" do
    put :update, :id => presentations(:one).to_param, :presentation => { }
    assert_redirected_to presentation_path(assigns(:presentation))
  end

  test "should destroy presentation" do
    assert_difference('Presentation.count', -1) do
      delete :destroy, :id => presentations(:one).to_param
    end

    assert_redirected_to presentations_path
  end
end
