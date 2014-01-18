class AddValueToRecurs < ActiveRecord::Migration
  def change
    add_column :recurs, :value, :integer, :default => 0
  end
end
