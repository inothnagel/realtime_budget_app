require 'spec_helper'

describe "data_points/show" do
  before(:each) do
    @data_point = assign(:data_point, stub_model(DataPoint,
      :metric => nil,
      :value => "Value"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Value/)
  end
end
