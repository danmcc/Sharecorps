require 'test_helper'

class ShareholdersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shareholders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shareholder" do
    assert_difference('Shareholder.count') do
      post :create, :shareholder => { }
    end

    assert_redirected_to shareholder_path(assigns(:shareholder))
  end

  test "should show shareholder" do
    get :show, :id => shareholders(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => shareholders(:one).to_param
    assert_response :success
  end

  test "should update shareholder" do
    put :update, :id => shareholders(:one).to_param, :shareholder => { }
    assert_redirected_to shareholder_path(assigns(:shareholder))
  end

  test "should destroy shareholder" do
    assert_difference('Shareholder.count', -1) do
      delete :destroy, :id => shareholders(:one).to_param
    end

    assert_redirected_to shareholders_path
  end
end
