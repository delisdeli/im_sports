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
    | name    |
    | league1 |

    Given the following divisions exist:
    | name    | num_teams  | start_time  | end_time  | num_locations  | num_weeks | year | month | day | game_length  | league_id  |
    | testdiv | 8          | 8pm         | 10pm      | 2              | 2         | 2013 | 11    | 18  | 60           | 1          |

Scenario: A non-admin should not be able to see adjust schedule button
  Given I am on the home page
  And I follow "league1"
  And I follow "testdiv"
  And I follow "team1 vs. team2"
  Then I should not see "Edit Time"
  Given I am logged in as "email2@email.com" with password "password"
  And I am on the home page
  And I follow "league1"
  And I follow "testdiv"
  And I follow "team1 vs. team2"
  Then I should not see "Edit Time"

Scenario: An admin should be able to edit a game
  Given I am logged in as "email@email.com" with password "password"
  And I am on the home page
  And I follow "league1"
  And I follow "testdiv"
  And I follow "team1 vs. team2"
  When I follow "Edit"
  When I select "09" from "game[start_time(4i)]"
  And I select "00" from "game[start_time(5i)]"
  And I press "Save"
  Then I should see "Game was successfully updated."
  When I go to the home page
  And I follow "league1"
  And I follow "testdiv"
  And I follow "team1 vs. team2"
  Then I should see "09:00 AM"

@javascript
Scenario: Can delete a game record
  Given I am logged in as "email@email.com" with password "password"
  And I am on the games page for division "div2" of league "league1"
  Then I should see "team1"
  Then I should see "team2"
  When I follow "Destroy"
  And I accept the alert
  Then I should be on the games page for division "div2" of league "league1"
  And I should not see "team1"
  And I should not see "team2"
