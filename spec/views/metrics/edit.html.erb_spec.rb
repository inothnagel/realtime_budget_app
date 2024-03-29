require 'spec_helper'

describe "metrics/edit" do
  before(:each) do
    @metric = assign(:metric, stub_model(Metric,
      :account => nil,
      :name => "MyString"
    ))
  end

  it "renders the edit metric form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => metrics_path(@metric), :method => "post" do
      assert_select "input#metric_account", :name => "metric[account]"
      assert_select "input#metric_name", :name => "metric[name]"
    end
  end
end
