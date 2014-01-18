require 'test_helper'

class RecursControllerTest < ActionController::TestCase
  setup do
    @recur = recurs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recurs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recur" do
    assert_difference('Recur.count') do
      post :create, recur: @recur.attributes
    end

    assert_redirected_to recur_path(assigns(:recur))
  end

  test "should show recur" do
    get :show, id: @recur
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recur
    assert_response :success
  end

  test "should update recur" do
    put :update, id: @recur, recur: @recur.attributes
    assert_redirected_to recur_path(assigns(:recur))
  end

  test "should destroy recur" do
    assert_difference('Recur.count', -1) do
      delete :destroy, id: @recur
    end

    assert_redirected_to recurs_path
  end
end
