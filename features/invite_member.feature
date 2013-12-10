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
    | name    | sport      |
    | league1 | basketball |
    | league2 | basketball |

    Given the following divisions exist:
    | name    | num_teams  | start_time  | end_time  | num_locations  | num_weeks | year | month | day | game_length  | league_id  |
    | testdiv | 8          | 8pm         | 10pm      | 2              | 7         | 2013 | 11    | 18  | 60           | 1          |

    Given the following teams exist:
    | captain_email      | name       | division_id | placeholder |
    | email2@email.com   | teamkewl   | 1           | false       |

  Scenario: A team captain should be able to invite members
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the home page
    And I follow "Basketball_icon"
    And I follow "league1"
    And I follow "testdiv"
    And I follow "teamkewl"
    Then I should be on the team page for "teamkewl" of division "testdiv" of league "league1"
    And I should see "Invite Player"
    When I fill in "to_invite" with "email4@email.com"
    And I press "Invite Player"
    Then I should see "email4@email.com has been invited."

  Scenario: A user that has been invited to join a team can accept the invite
    Given I am logged in as "email4@email.com" with password "password"
    And user with email "email4@email.com" has been invited to join "teamkewl"
    And I am on the profile page for "email4@email.com"
    Then I should see "Invitation to join teamkewl"
    When I press "Accept invitation to join teamkewl"
    Given I am on the team page for "teamkewl" of division "testdiv" of league "league1"
    Then I should see "Roster" before "user2"

  Scenario: A user that has been invited to join a team can dismiss the invite
    Given I am logged in as "email4@email.com" with password "password"
    And user with email "email4@email.com" has been invited to join "teamkewl"
    And I am on the profile page for "email4@email.com"
    Then I should see "Invitation to join teamkewl"
    When I press "Dismiss invitation to join teamkewl"
    Then I should be on the profile page for "email4@email.com"
    And I should not see "Invititation to join teamkewl"
    And I should see "Successfully dismissed invite"
    Given I am on the team page for "teamkewl" of division "testdiv" of league "league1"
    Then I should not see "Roster" before "user2"

  Scenario: A member should not be able to invite members
    Given I am logged in as "email3@email.com" with password "password"
    And I am on the home page
    And I follow "Basketball_icon"
    And I follow "league1"
    And I follow "testdiv"
    And I follow "teamkewl"
    Then I should be on the team page for "teamkewl" of division "testdiv" of league "league1"
    And I should not see "Invite Player"
