class CreateTableAccountsUsers < ActiveRecord::Migration
  def change
    create_table :accounts_users, :id => false do |t|
      t.references :account, :null => false
      t.references :user, :null => false
    end

    add_index(:accounts_users, [:account_id, :user_id], :unique => true)
  end
end
