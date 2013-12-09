# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^the signup page$/
      '/signup'
    when /^the signin page$/
      '/signin'
    when /^the edit page for user "(.*)"$/
      user_id = User.find_by_email($1).id
      '/users/1/edit'
    when /^the league page for "(.*)"$/
      league_id = League.find_by_name($1).id
      "/leagues/#{league_id}"
    when /^the team page for "(.*)" of division "(.*)" of league "(.*)"$/
      team_id = Team.find_by_name($1).id
      division_id = Division.find_by_name($2).id
      league_id = League.find_by_name($3).id
      "/leagues/#{league_id}/divisions/#{division_id}/teams/#{team_id}"
    when /^the teams page for division "(.*)" of league "(.*)"$/
      division_id = Division.find_by_name($1).id
      league_id = League.find_by_name($2).id
      "/leagues/#{league_id}/divisions/#{division_id}/teams"
    when /^the profile page for "(.*)"$/
      user_id = User.find_by_email($1).id
      "/users/#{user_id}"
    when /^the division page for "(.*)" of league "(.*)"$/
      division_id = Division.find_by_name($1).id
      league_id = League.find_by_name($2).id
      "/leagues/#{league_id}/divisions/#{division_id}"
    when /^the divisions page for league "(.*)"$/
      league_id = League.find_by_name($1).id
      "/leagues/#{league_id}/divisions"

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
