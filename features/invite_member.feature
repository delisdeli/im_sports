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
    | user2      | email4@email.com  | password  | password               | false  |

    Given the following leagues exist:
    | name    |
    | league1 |
    | league2 |

    Given the following teams exist:
    | captain_email      | name    | league_id |
    | email2@email.com   | team1   | 1         |

  Scenario: A team captain should be able to invite members
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the home page
    And I follow "league1"
    And I follow "team1"
    Then I should be on the team page for "team1" of league "league1"
    And I should see "Invite Player"
    When I fill in "to_invite" with "email4@email.com"
    And I press "Invite Player"
    Then I should see "email4@email.com has been invited."

  Scenario: A user that has been invited to join a team should see the invite
    Given I am logged in as "email4@email.com" with password "password"
    And user with email "email4@email.com" has been invited to join "team1"
    And I am on the profile page for "email4@email.com"
    Then I should see "Invitation to team1"
    When I press "Acccept"
    Then I should see "You have successfully joined team1"

  Scenario: A member should not be able to invite members
    Given I am logged in as "email3@email.com" with password "password"
    And I am on the home page
    And I follow "league1"
    And I follow "team1"
    Then I should be on the team page for "team1" of league "league1"
    And I should not see "Invite Player"