class AddSplitAccountToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :split_account_id, :integer
  end
end
