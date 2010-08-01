require 'test_helper'

class TaskSharesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:task_shares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task_share" do
    assert_difference('TaskShare.count') do
      post :create, :task_share => { }
    end

    assert_redirected_to task_share_path(assigns(:task_share))
  end

  test "should show task_share" do
    get :show, :id => task_shares(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => task_shares(:one).to_param
    assert_response :success
  end

  test "should update task_share" do
    put :update, :id => task_shares(:one).to_param, :task_share => { }
    assert_redirected_to task_share_path(assigns(:task_share))
  end

  test "should destroy task_share" do
    assert_difference('TaskShare.count', -1) do
      delete :destroy, :id => task_shares(:one).to_param
    end

    assert_redirected_to task_shares_path
  end
end
