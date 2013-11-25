Given /the following teams exist/ do |teams_table|
  teams_table.hashes.each do |team|
    current_team = Team.create!(team)
    Division.find_by_id(team[:division_id]).teams << current_team
  end
end

Given /the following leagues exist/ do |leagues_table|
  leagues_table.hashes.each do |league|
    League.create!(league)
  end
end

And /user with email "(.*)" has been invited to join "(.*)"$/ do |email, team_name|
  user = User.find_by_email(email)
  team = Team.find_by_name(team_name)
  invitation = Invitation.new('user' => user, 'team' => team)
  user.invitations << invitation
  team.invitations << invitation
end

And /I am a member of "(.*)"/ do |team_name| 
  

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert page.body =~ /#{e1}.*#{e2}/m, "not sorted correctly"
end
