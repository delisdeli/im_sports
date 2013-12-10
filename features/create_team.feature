Feature: Create teams

As a team captain
So that I can have a team play in the season
I want to be able to start a team in a league

  Background:
    Given the following users exist:
    | name       | email             | password  | password_confirmation  | admin  |
    | admin      | email@email.com   | password  | password               | true   |
    | user       | email2@email.com  | password  | password               | false  |
    | bob        | email3@email.com  | password  | password               | false  |

    Given the following leagues exist:
    | name    | sport      |
    | league1 | basketball |
    | league2 | basketball |

    Given the following divisions exist:
    | name    | num_teams  | start_time  | end_time  | num_locations  | num_weeks | year | month | day | game_length  | league_id  |
    | testdiv | 8          | 8pm         | 10pm      | 2              | 2         | 2013 | 11    | 18  | 60           | 1          |

    Given the following teams exist:
    | captain_email      | name     | division_id   | placeholder |
    | email2@email.com   | teamcool   | 1           | false       |

  Scenario: A user should be able to create a team
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the home page
    And I follow "Basketball_icon"
    And I follow "league1"
    And I follow "testdiv"
    And I follow "Create Team"
    And I fill in "team[name]" with "teamlame"
    And I press "Create Team"
    Then I should be on the team page for "teamlame" of division "testdiv" of league "league1"
    And I should see "teamlame"
    And I should see "Roster" before "user"
    Given I am on the profile page for "email2@email.com"
    Then I should see "teamlame"
    Given I am on the teams page for division "testdiv" of league "league1"
    Then I should see "teamlame"

  Scenario: A non-user should not be able to create a team
    Given I am on the division page for "testdiv" of league "league1"
    Then I should not see "Create Team"

  Scenario: all the teams for a division can be seen on the division page
    Given I am on the division page for "testdiv" of league "league1"
    Then I should see "teamcool"

  Scenario: Fake teams should not show up in teams index
    Given I am on the teams page for division "testdiv" of league "league1"
    Then I should see "teamcool"
    And I should not see "team4"

  Scenario: Team captain can update a team
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the team page for "teamcool" of division "testdiv" of league "league1"
    When I follow "Edit"
    And I fill in "team[name]" with "teamlame"
    And I press "Create Team"
    Then I should be on the team page for "teamlame" of division "testdiv" of league "league1"

  @javascript
  Scenario: Team captain can delete a team
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the teams page for division "testdiv" of league "league1"
    Then I should see "teamcool"
    When I follow "teamcool"
    When I follow "Destroy Team"
    And I accept the alert
    Then I should be on the teams page for division "testdiv" of league "league1"
    And I should not see "teamcool"

  @javascript
  Scenario: A non-admin non-team captain cannot delete a team
    Given I am logged in as "email3@email.com" with password "password"
    And I am on the teams page for division "testdiv" of league "league1"
    Then I should see "teamcool"
    When I follow "teamcool"
    When I follow "Destroy Team"
    And I accept the alert
    Then I should be on the teams page for division "testdiv" of league "league1"
    And I should see "teamcool"
    And I should see "You are not authorized"

  @javascript
  Scenario: An admin can delete a team
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the teams page for division "testdiv" of league "league1"
    Then I should see "teamcool"
    When I follow "teamcool"
    When I follow "Destroy"
    And I accept the alert
    Then I should be on the teams page for division "testdiv" of league "league1"
    And I should not see "teamcool"
