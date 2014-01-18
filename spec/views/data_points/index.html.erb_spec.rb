require 'spec_helper'

describe "data_points/index" do
  before(:each) do
    assign(:data_points, [
      stub_model(DataPoint,
        :metric => nil,
        :value => "Value"
      ),
      stub_model(DataPoint,
        :metric => nil,
        :value => "Value"
      )
    ])
  end

  it "renders a list of data_points" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
  end
end
