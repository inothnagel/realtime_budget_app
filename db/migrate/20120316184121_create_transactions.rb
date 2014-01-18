class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :user
      t.references :account
      t.integer :value
      t.string :description
      t.boolean :executed
      t.date :execution_delay_date
      t.datetime :datetime_executed

      t.timestamps
    end
    add_index :transactions, :user_id
  end
end
