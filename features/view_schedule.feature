Feature: View the schedule of a division
  
  As a team member
  So that I know when to show up for a game
  I want to be able to view the schedule of my team's division

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

    Given the following teams exist:
    | captain_email      | name       | division_id | placeholder |
    | email2@email.com   | testteam   | 1           | false       |

  Scenario: A user should be able to view his/her schedule via the division's page
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the home page
    And I follow "league1"
    And I follow "testdiv"
    Then I should see "testteam vs. team2"
    And I should see "testteam vs. team3"
    And I should see "testteam vs. team4"
    And I should see "testteam vs. team5"
    And I should see "testteam vs. team6"
    And I should see "testteam vs. team7"
    And I should see "testteam vs. team8"

  Scenario: A user should be able to view his/her schedule via the user's profile
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the profile page for "email2@email.com"
    And I follow "testteam"
    Then I should see "testteam vs. team2"
    And I should see "testteam vs. team3"
    And I should see "testteam vs. team4"
    And I should see "testteam vs. team5"
    And I should see "testteam vs. team6"
    And I should see "testteam vs. team7"
    And I should see "testteam vs. team8"
