Feature: Adjust the schedule of a division
  As a league administrator
  So that I can reschedule games if needed
  I want to be able to adjust the schedule of a division

  Background:
    Given the following users exist:
    | name       | email             | password  | password_confirmation  | admin  |
    | admin      | email@email.com   | password  | password               | true   |
    | user       | email2@email.com  | password  | password               | false  |

    Given the following leagues exist:
    | name    | sport      |
    | league1 | basketball |

    Given the following divisions exist:
    | name    | num_teams  | start_time  | end_time  | num_locations  | num_weeks | year | month | day | game_length  | league_id  |
    | testdiv | 8          | 8pm         | 10pm      | 2              | 2         | 2013 | 11    | 18  | 60           | 1          |
    | div2    | 2          | 8pm         | 9pm       | 1              | 1         | 2013 | 11    | 18  | 60           | 1          |

Scenario: A non-admin should not be able to see adjust schedule button
  Given I am on the home page
  And I follow "Basketball_icon"
  And I follow "league1"
  And I follow "testdiv"
  Then I should not see "Edit Time"

Scenario: An admin should be able to edit a game
  Given I am logged in as "email@email.com" with password "password"
  Given I am on the home page
  And I follow "Basketball_icon"
  And I follow "league1"
  And I follow "testdiv"
  When I follow "Edit Placeholder Team 1 vs. Placeholder Team 3"
  When I select "09" from "game[start_time(4i)]"
  And I select "00" from "game[start_time(5i)]"
  And I press "Save"
  Then I should see "Game was successfully updated."
  When I go to the home page
  And I follow "Basketball_icon"
  And I follow "league1"
  And I follow "testdiv"
  #And I follow "Placeholder Team 1 vs. Placeholder Team 3"
  Then I should see "09:00 AM"

Scenario: An admin adding a real location replaces placeholder locations
  Given I am logged in as "email@email.com" with password "password"
  And I am on the division page for "testdiv" of league "league1"
  When I fill in "new_location" with "RSF"
  And I press "Add Location"
  Then I should see "RSF"
  When I fill in "new_location" with "Haas"
  And I press "Add Location"
  Then I should see "Haas"

Scenario: An admin deleting a location restores placeholder locations
  Given I am logged in as "email@email.com" with password "password"
  And I am on the division page for "testdiv" of league "league1"
  When I fill in "new_location" with "RSF"
  And I press "Add Location"
  Then I should not see "Placeholder Location 1"
  When I press "Remove RSF"
  Then I should see "Placeholder Location 1"

Scenario: An admin can add a new game to a division
  Given I am logged in as "email@email.com" with password "password"
  And I am on the division page for "testdiv" of league "league1"
  When I follow "Add a New Game"
  And I fill in "game[team1_id]" with "1"
  And I fill in "game[team2_id]" with "2"
  And I fill in "game[score1]" with "0"
  And I fill in "game[score2]" with "0"
  And I select "2013" from "game[date(1i)]"
  And I select "December" from "game[date(2i)]"
  And I select "10" from "game[date(3i)]"
  And I select "10" from "game[start_time(4i)]"
  And I select "30" from "game[start_time(5i)]"
  And I select "12" from "game[end_time(4i)]"
  And I select "30" from "game[end_time(5i)]"
  And I select "Scheduled" from "game[status]"
  And I fill in "game[location]" with "RSF"
  And I press "Save"
  Then I should see "Game was successfully created"

@javascript
Scenario: Can delete a game record
  Given I am logged in as "email@email.com" with password "password"
  And I am on the division page for "div2" of league "league1"
  And I follow "Destroy Placeholder Team 1 vs. Placeholder Team 2"
  And I accept the alert
  Then I should be on the division page for "div2" of league "league1"
  And I should not see "Placeholder Team 1"
  And I should not see "Placeholder Team 2"
