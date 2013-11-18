require 'spec_helper'

describe "divisions/new" do
  before(:each) do
    assign(:division, stub_model(Division,
      :league => nil,
      :name => "MyString",
      :num_teams => "",
      :num_locations => ""
    ).as_new_record)
  end

  it "renders new division form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", divisions_path, "post" do
      assert_select "input#division_league[name=?]", "division[league]"
      assert_select "input#division_name[name=?]", "division[name]"
      assert_select "input#division_num_teams[name=?]", "division[num_teams]"
      assert_select "input#division_num_locations[name=?]", "division[num_locations]"
    end
  end
end
