class AddLabelTometrics < ActiveRecord::Migration
  def change
    add_column :metrics, :label, :string
  end
end
