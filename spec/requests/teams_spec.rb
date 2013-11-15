require 'spec_helper'

describe "Teams" do
  describe "GET /teams" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get league_teams_path("1")
      response.status.should be(200)
    end
  end
end
