require 'test_helper'

class DecisionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:decisions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create decision" do
    assert_difference('Decision.count') do
      post :create, :decision => { }
    end

    assert_redirected_to decision_path(assigns(:decision))
  end

  test "should show decision" do
    get :show, :id => decisions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => decisions(:one).to_param
    assert_response :success
  end

  test "should update decision" do
    put :update, :id => decisions(:one).to_param, :decision => { }
    assert_redirected_to decision_path(assigns(:decision))
  end

  test "should destroy decision" do
    assert_difference('Decision.count', -1) do
      delete :destroy, :id => decisions(:one).to_param
    end

    assert_redirected_to decisions_path
  end
end
