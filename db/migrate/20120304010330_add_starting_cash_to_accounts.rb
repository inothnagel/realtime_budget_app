class AddStartingCashToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :starting_cash, :integer

  end
end
