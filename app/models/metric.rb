class Metric < ActiveRecord::Base
  belongs_to :account
  has_many :data_points

  def datapoints
    data_points
  end

  def add_datapoint(time, value)
    datapoint = datapoints.create(:value=>value)
    datapoint.created_at = time
    datapoint.save
  end
end
