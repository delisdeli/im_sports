Feature: invite a member to join team

  As a team captain
  I want to be able to send invites to my team members to join the team
  So that they can securely join

  Background:
    Given the following users exist:
    | name       | email             | password  | password_confirmation  | admin  |
    | admin      | email@email.com   | password  | password               | true   |
    | user       | email2@email.com  | password  | password               | false  |
    | user1      | email3@email.com  | password  | password               | false  |

  Scenario: A team captain should be able to invite members
    Given I am logged in as "email2@email.com" with password "password"
    And I am the captain of "team1" of "league1"
    And I am on the home page
    And I follow "league1"
    And I follow "team1"
    #Then I should be on the team page for "team1" of league "league1"
    Then I should see "invite"

  Scenario: A member should not be able to invite members
    Given I am logged in as "email3@email.com" with password "password"
    And I am a member of "team1" of "league1"
    And I am on the home page
    And I follow "league1"
    And I follow "team1"
    #Then I should be on the team page for "team1" of league "league1"
    Then I should not see "invite"
