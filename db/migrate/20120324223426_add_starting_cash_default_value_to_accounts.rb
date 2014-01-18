class AddStartingCashDefaultValueToAccounts < ActiveRecord::Migration
  def change
    change_column :accounts, :starting_cash, :integer, :default => 0
  end
end
