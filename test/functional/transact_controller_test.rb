require 'test_helper'

class TransactControllerTest < ActionController::TestCase
  test "should get transaction" do
    get :transaction
    assert_response :success
  end

  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get remove" do
    get :remove
    assert_response :success
  end

end
