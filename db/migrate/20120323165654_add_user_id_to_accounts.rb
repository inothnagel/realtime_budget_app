class AddUserIdToAccounts < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.references :user
    end
  end
end
