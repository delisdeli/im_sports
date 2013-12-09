Feature: Assign my team a slot in the division's schedule

  As a team captain
  I want to be able to sign up for a division and replace a placeholder team in the schedule
  So that I can have a schedule for my team

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
  | testdiv | 2          | 8pm         | 9pm       | 1              | 1         | 2013 | 11    | 18  | 60           | 1          |

  Scenario: A team captain can create a team for a division and be assigned a slot
    Given I am logged in as "email@email.com" with password "password"
    And I am on the division page for "testdiv" of league "league1"
    Then I should see "Placeholder Team 1 vs. Placeholder Team 2"
    When I follow "Create Team"
    And I fill in "team[name]" with "teamawesome"
    And I press "Create Team"
    When I follow "Sign out"
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the division page for "testdiv" of league "league1"
    Then I should see "teamawesome vs. Placeholder Team 2"
    When I follow "Create Team"
    And I fill in "team[name]" with "teamlame"
    And I press "Create Team"
    Given I am on the division page for "testdiv" of league "league1"
    Then I should see "teamawesome vs. teamlame"
    And I should not see "Placeholder Team 1"
    And I should not see "Placeholder Team 2"

  @javascript
  Scenario: A team captain deleting a team replaces the team with a placeholder
    Given I am logged in as "email@email.com" with password "password"
    And I am on the division page for "testdiv" of league "league1"
    Then I should see "Placeholder Team 1 vs. Placeholder Team 2"
    When I follow "Create Team"
    And I fill in "team[name]" with "teamawesome"
    And I press "Create Team"
    Given I am on the division page for "testdiv" of league "league1"
    When I follow "Create Team"
    And I fill in "team[name]" with "teamlame"
    And I press "Create Team"
    Given I am on the teams page for division "testdiv" of league "league1"
    When I follow "teamawesome"
    And I follow "Destroy"
    And I accept the alert
    And I follow "teamlame"
    And I follow "Destroy"
    And I accept the alert
    Given I am on the division page for "testdiv" of league "league1"
    Then I should see "Placeholder Team 2 vs. Placeholder Team 1"
    And I should not see "teamawesome"
    And I should not see "teamlame"
