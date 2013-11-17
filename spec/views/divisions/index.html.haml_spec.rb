require 'spec_helper'

describe "divisions/index" do
  before(:each) do
    assign(:divisions, [
      stub_model(Division,
        :league => nil,
        :name => "Name",
        :num_teams => "",
        :num_locations => ""
      ),
      stub_model(Division,
        :league => nil,
        :name => "Name",
        :num_teams => "",
        :num_locations => ""
      )
    ])
  end

  it "renders a list of divisions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
