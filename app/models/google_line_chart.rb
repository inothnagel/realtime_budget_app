class GoogleLineChart
  def data_for(datapoints)
    data = []
    datapoints.order('created_at').each do |d|
      data << [d.created_at.to_s, d.value.to_i]
    end
    data
  end
end