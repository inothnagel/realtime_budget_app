require 'spec_helper'

describe "data_points/new" do
  before(:each) do
    assign(:data_point, stub_model(DataPoint,
      :metric => nil,
      :value => "MyString"
    ).as_new_record)
  end

  it "renders new data_point form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => data_points_path, :method => "post" do
      assert_select "input#data_point_metric", :name => "data_point[metric]"
      assert_select "input#data_point_value", :name => "data_point[value]"
    end
  end
end
