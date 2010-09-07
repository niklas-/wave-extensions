require 'test_helper'

class Admin::TagsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tag" do
    assert_difference('Admin::Tag.count') do
      post :create, :tag => { }
    end

    assert_redirected_to tag_path(assigns(:tag))
  end

  test "should show tag" do
    get :show, :id => admin_tags(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_tags(:one).to_param
    assert_response :success
  end

  test "should update tag" do
    put :update, :id => admin_tags(:one).to_param, :tag => { }
    assert_redirected_to tag_path(assigns(:tag))
  end

  test "should destroy tag" do
    assert_difference('Admin::Tag.count', -1) do
      delete :destroy, :id => admin_tags(:one).to_param
    end

    assert_redirected_to admin_tags_path
  end
end
