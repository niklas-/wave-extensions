require 'test_helper'

class Admin::ExtensionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_extensions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extension" do
    assert_difference('Admin::Extension.count') do
      post :create, :extension => { }
    end

    assert_redirected_to extension_path(assigns(:extension))
  end

  test "should show extension" do
    get :show, :id => admin_extensions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_extensions(:one).to_param
    assert_response :success
  end

  test "should update extension" do
    put :update, :id => admin_extensions(:one).to_param, :extension => { }
    assert_redirected_to extension_path(assigns(:extension))
  end

  test "should destroy extension" do
    assert_difference('Admin::Extension.count', -1) do
      delete :destroy, :id => admin_extensions(:one).to_param
    end

    assert_redirected_to admin_extensions_path
  end
end
