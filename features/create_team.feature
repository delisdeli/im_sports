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

  Scenario: A user should be able to create a team
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the home page
    And I follow "league1"
    And I follow "Create Team"
    And I fill in "team[name]" with "team1"
    And I press "Create Team"
    Then I should be on the team page for "team1" of league "league1"
    And I should see "team1"

  Scenario: A non-user should not be able to create a team
    Given I am on the home page
    And I follow "league1"
    And I follow "Create Team"
    Then I should be on the signin page
    And I should see "Please sign in"
