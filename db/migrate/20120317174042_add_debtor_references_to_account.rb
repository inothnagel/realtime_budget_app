class AddDebtorReferencesToAccount < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.references :debtor
    end
  end
end
