require 'spec_helper'

describe "Transactions" do
  describe "GET /transactions" do
    it "works! (now write some real specs)" do
      pending
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get transactions_path
      response.status.should be(200)
    end
  end

  describe "reversing a transaction" do
    it 'lets the user reverse a transaction' do
      pending
      @user = User.create
      sign_in @user
      
      @account = Account.create
      @transaction = @account.transactions.create(:value => -100)
      get "/transactions/#{@transaction.id}"

      response.body.should include("Reverse Transaction")
    end
  end
end
