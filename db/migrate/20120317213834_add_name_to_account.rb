class AddNameToAccount < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.string :name, :default => "Unnamed Account"
    end
  end
end
