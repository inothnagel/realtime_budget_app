class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.references :account
      t.string :name

      t.timestamps
    end
    add_index :metrics, :account_id
  end
end
