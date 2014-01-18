class AddAccountValueToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :account_value, :integer, :default=>0
  end
end
