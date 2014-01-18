class CreateRecurs < ActiveRecord::Migration
  def change
    create_table :recurs do |t|
      t.string :name
      t.datetime :last_recur
      t.datetime :next_recur
      t.references :account
      t.references :user

      t.timestamps
    end
    add_index :recurs, :account_id
    add_index :recurs, :user_id
  end
end
