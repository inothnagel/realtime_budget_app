class CreateDebtors < ActiveRecord::Migration
  def change
    create_table :debtors do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
