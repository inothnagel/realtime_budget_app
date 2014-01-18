class CreateDebtorAccounts < ActiveRecord::Migration
  def change
    create_table :debtor_accounts do |t|
      t.integer :amount
      t.references :debtor

      t.timestamps
    end
    add_index :debtor_accounts, :debtor_id
  end
end
