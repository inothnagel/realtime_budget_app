class AddBudgetToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :budget, :integer
  end
end
