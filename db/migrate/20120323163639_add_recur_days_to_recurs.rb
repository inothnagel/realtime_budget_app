class AddRecurDaysToRecurs < ActiveRecord::Migration
  def change
    change_table :recurs do |t|
      t.string :recur_days
    end
  end
end
