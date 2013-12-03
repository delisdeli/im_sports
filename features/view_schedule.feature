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
    | testdiv | 8          | 8pm         | 10pm      | 2              | 7         | 2013 | 11    | 18  | 60           | 1          |

    Given the following teams exist:
    | captain_email      | name               | division_id | placeholder |
    | email2@email.com   | Placeholder Team 1 | 1           | false       |

  Scenario: A user should be able to view his/her schedule via the division's page
    Given I am logged in as "email2@email.com" with password "password"
    And user with email "email2@email.com" is a member of "Placeholder Team 1"
    And I am on the home page
    And I follow "league1"
    And I follow "testdiv"
    Then I should see "Placeholder Team 1 vs. Placeholder Team 2" or "Placeholder Team 2 vs. Placeholder Team 1"
    And I should see "Placeholder Team 1 vs. Placeholder Team 3" or "Placeholder Team 3 vs. Placeholder Team 1"
    And I should see "Placeholder Team 1 vs. Placeholder Team 4" or "Placeholder Team 4 vs. Placeholder Team 1"
    And I should see "Placeholder Team 1 vs. Placeholder Team 5" or "Placeholder Team 5 vs. Placeholder Team 1"
    And I should see "Placeholder Team 1 vs. Placeholder Team 6" or "Placeholder Team 6 vs. Placeholder Team 1"
    And I should see "Placeholder Team 1 vs. Placeholder Team 7" or "Placeholder Team 7 vs. Placeholder Team 1"
    And I should see "Placeholder Team 1 vs. Placeholder Team 8" or "Placeholder Team 8 vs. Placeholder Team 1"

  Scenario: A user should be able to view his/her schedule via the user's profile
    Given I am logged in as "email2@email.com" with password "password"
    And user with email "email2@email.com" is a member of "Placeholder Team 1"
    And I am on the profile page for "email2@email.com"
    And I follow "Placeholder Team 1"
    Then I should see "Placeholder Team 1 vs. Placeholder Team 2" or "Placeholder Team 2 vs. Placeholder Team 1"
    And I should see "Placeholder Team 1 vs. Placeholder Team 3" or "Placeholder Team 3 vs. Placeholder Team 1"
    And I should see "Placeholder Team 1 vs. Placeholder Team 4" or "Placeholder Team 4 vs. Placeholder Team 1"
    And I should see "Placeholder Team 1 vs. Placeholder Team 5" or "Placeholder Team 5 vs. Placeholder Team 1"
    And I should see "Placeholder Team 1 vs. Placeholder Team 6" or "Placeholder Team 6 vs. Placeholder Team 1"
    And I should see "Placeholder Team 1 vs. Placeholder Team 7" or "Placeholder Team 7 vs. Placeholder Team 1"
    And I should see "Placeholder Team 1 vs. Placeholder Team 8" or "Placeholder Team 8 vs. Placeholder Team 1"
