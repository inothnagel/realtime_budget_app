class DropDebtorsAccountTable < ActiveRecord::Migration
  def up
    drop_table :debtor_accounts
  end

  def down
    drop_table :debtor_accounts
  end
end
