require 'test_helper'

class CallQueuesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:queues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create queue" do
    assert_difference('CallQueue.count') do
      post :create, :queue => { }
    end

    assert_redirected_to queue_path(assigns(:queue))
  end

  test "should show queue" do
    get :show, :id => queues(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => queues(:one).to_param
    assert_response :success
  end

  test "should update queue" do
    put :update, :id => queues(:one).to_param, :queue => { }
    assert_redirected_to queue_path(assigns(:queue))
  end

  test "should destroy queue" do
    assert_difference('CallQueue.count', -1) do
      delete :destroy, :id => queues(:one).to_param
    end

    assert_redirected_to queues_path
  end
end
