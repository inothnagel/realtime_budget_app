require 'spec_helper'

describe "data_points/edit" do
  before(:each) do
    @data_point = assign(:data_point, stub_model(DataPoint,
      :metric => nil,
      :value => "MyString"
    ))
  end

  it "renders the edit data_point form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => data_points_path(@data_point), :method => "post" do
      assert_select "input#data_point_metric", :name => "data_point[metric]"
      assert_select "input#data_point_value", :name => "data_point[value]"
    end
  end
end
