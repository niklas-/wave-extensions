require 'test_helper'

class Admin::CategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Admin::Category.count') do
      post :create, :category => { }
    end

    assert_redirected_to category_path(assigns(:category))
  end

  test "should show category" do
    get :show, :id => admin_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_categories(:one).to_param
    assert_response :success
  end

  test "should update category" do
    put :update, :id => admin_categories(:one).to_param, :category => { }
    assert_redirected_to category_path(assigns(:category))
  end

  test "should destroy category" do
    assert_difference('Admin::Category.count', -1) do
      delete :destroy, :id => admin_categories(:one).to_param
    end

    assert_redirected_to admin_categories_path
  end
end
