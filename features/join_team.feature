Feature: User can securely join a team

  As a team member
  So that I can be registered to play during the season
  I want to be able to securely join a team

  Background:
    Given the following users exist:
    | name       | email             | password  | password_confirmation  | admin  |
    | admin      | email@email.com   | password  | password               | true   |
    | user1      | email2@email.com  | password  | password               | false  |
    | user2      | email3@email.com  | password  | password               | false  |

    Given the following leagues exist:
    | name    |
    | league1 |

    Given the following divisions exist:
    | name    | num_teams  | start_time  | end_time  | num_locations  | game_length  | league_id  |
    | testdiv | 8          | 8pm         | 10pm      | 2              | 60           | 1          |

    Given the following teams exist:
    | captain_email   | name  | division_id |
    | email@email.com | team1 | 1           | 

  Scenario: An invited member can accept the invitation and join the team
    Given I am logged in as "email2@email.com" with password "password"
    And user with email "email2@email.com" has been invited to join "team1"
    And I am on the profile page for "email2@email.com"
    Then I should see "Invitation to join team1"
    When I press "Accept invitation to join team1"
    Then I should be on the profile page for "email2@email.com"
    And I should see "Successfully joined team1"
    And I should not see "Accept invitation to join team1"

  Scenario: A non-invited member cannot join the team
    Given I am logged in as "email3@email.com" with password "password"
    And user with email "email2@email.com" has been invited to join "team1"
    And I am on the profile page for "email2@email.com"
    Then I should not see "Invitation to join team1"

  Scenario: Once a member has been successfully invited, the division page should display the member
    Given I am logged in as "email2@email.com" with password "password"
    And user with email "email2@email.com" has been invited to join "team1"
    And I am on the profile page for "email2@email.com"
    And I press "Accept invitation to join team1"
    When I go to the homepage
    Then I should see "league1"
    When I follow "league1"
    And I follow "testdiv"
    And I follow "team1"
    Then I should see "user1"
    And I should not see "user300"
    When I follow "user1"
    Then I should see "user1"
    And I should see "email2@email.com"
