class CreateDataPoints < ActiveRecord::Migration
  def change
    create_table :data_points do |t|
      t.references :metric
      t.string :value

      t.timestamps
    end
    add_index :data_points, :metric_id
  end
end
