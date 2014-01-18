class AddRecurToTransactions < ActiveRecord::Migration
  def change
    change_table :transactions do |t|
      t.references :recur
    end
  end
end
