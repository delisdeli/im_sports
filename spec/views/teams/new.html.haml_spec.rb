require 'spec_helper'

describe "teams/new" do
  before(:each) do
    assign(:team, stub_model(Team,
      :captain_email => "MyString",
      :name => "MyString",
      :league => nil
    ).as_new_record)
  end

  it "renders new team form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", teams_path, "post" do
      assert_select "input#team_captain_email[name=?]", "team[captain_email]"
      assert_select "input#team_name[name=?]", "team[name]"
      assert_select "input#team_league[name=?]", "team[league]"
    end
  end
end
