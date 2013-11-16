Feature: Create teams

As a team captain
So that I can have a team play in the season
I want to be able to start a team in a league

  Background:
    Given the following users exist:
    | name       | email             | password  | password_confirmation  | admin  |
    | admin      | email@email.com   | password  | password               | true   |
    | user       | email2@email.com  | password  | password               | false  |

    Given the following leagues exist:
    | name    |
    | league1 |
    | league2 |

    Given the following teams exist:
    | captain_email      | name     | league_id |
    | email2@email.com   | team10   | 1         |

  Scenario: A user should be able to create a team
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the home page
    And I follow "league1"
    And I follow "Create Team"
    And I fill in "team[name]" with "team1"
    And I press "Create Team"
    Then I should be on the team page for "team1" of league "league1"
    And I should see "team1"
    And I should see "league1"
    And I should see "Team Members" before "user"
    And I am on the profile page for "email2@email.com"
    Then I should see "team1"

  Scenario: A non-user should not be able to create a team
    Given I am on the home page
    And I follow "league1"
    And I follow "Create Team"
    Then I should be on the signin page
    And I should see "Please sign in"

  Scenario: all the teams for a league can be seen on the league page
    And I am on the league page for "league1"
    Then I should see "team10"

  Scenario: Team captain can update a team
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the team page for "team10" of league "league1"
    When I follow "Edit"
    And I fill in "team[name]" with "team5"
    And I press "Create Team"
    Then I should be on the team page for "team5" of league "league1"

  @javascript
  Scenario: Team captain can delete a team
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the teams page for "league1"
    Then I should see "team10"
    When I follow "Destroy"
    And I accept the alert
    Then I should be on the teams page for "league1"
    And I should not see "team10"
