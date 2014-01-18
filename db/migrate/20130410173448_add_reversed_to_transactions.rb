class AddReversedToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :reversed, :boolean
  end
end
