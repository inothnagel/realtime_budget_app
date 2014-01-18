require 'test_helper'

class DebtorAccountsControllerTest < ActionController::TestCase
  setup do
    @debtor_account = debtor_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:debtor_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create debtor_account" do
    assert_difference('DebtorAccount.count') do
      post :create, debtor_account: @debtor_account.attributes
    end

    assert_redirected_to debtor_account_path(assigns(:debtor_account))
  end

  test "should show debtor_account" do
    get :show, id: @debtor_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @debtor_account
    assert_response :success
  end

  test "should update debtor_account" do
    put :update, id: @debtor_account, debtor_account: @debtor_account.attributes
    assert_redirected_to debtor_account_path(assigns(:debtor_account))
  end

  test "should destroy debtor_account" do
    assert_difference('DebtorAccount.count', -1) do
      delete :destroy, id: @debtor_account
    end

    assert_redirected_to debtor_accounts_path
  end
end
