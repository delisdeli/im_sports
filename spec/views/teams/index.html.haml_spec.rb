require 'spec_helper'

describe "leagues/1/teams/index" do
  before(:each) do
    assign(:teams, [
      stub_model(Team,
        :captain_email => "Captain Email",
        :name => "Name",
        :league_id => "1"
      ),
      stub_model(Team,
        :captain_email => "Captain Email",
        :name => "Name",
        :league_id => "1"
      )
    ])
  end

  it "renders a list of teams" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Captain Email".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
