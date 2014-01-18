class DropColumnUserIdOnAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :user_id
  end
end
