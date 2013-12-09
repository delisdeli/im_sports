Feature: Notify teams when schedule is altered

  As a league administrator 
  I want to be able to send a notification when I modify the schedule
  So that teams and players know when schedules have been changed

  Background:
    Given the following users exist:
    | name       | email             | password  | password_confirmation  | admin  |
    | admin      | email@email.com   | password  | password               | true   |
    | user       | email2@email.com  | password  | password               | false  |
    | user       | email3@email.com  | password  | password               | false  |
    Given the following leagues exist:
    | name    | sport      |
    | league1 | basketball |

    Given the following divisions exist:
    | name    | num_teams  | start_time  | end_time  | num_locations  | num_weeks | year | month | day | game_length  | league_id  |
    | div2    | 2          | 8pm         | 9pm       | 1              | 1         | 2013 | 11    | 18  | 60           | 1          |

  Scenario: A team member should see a notification when schedule has been altered
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the division page for "div2" of league "league1"
    When I follow "Create Team"
    And I fill in "team[name]" with "teamlame"
    And I press "Create Team"
    And I follow "Sign out"
    Given I am logged in as "email@email.com" with password "password"
    And I am on the division page for "div2" of league "league1"
    When I follow "Create Team"
    And I fill in "team[name]" with "teamcool"
    And I press "Create Team"
    And I am on the division page for "div2" of league "league1"
    And I follow "teamlame vs. teamcool"
    And I follow "Edit"
    And I fill in "game[location]" with "haas pav"
    And I press "Save"
    Given I am on the homepage
    When I follow "Notifications"
    Then I should see "Schedule was changed" 

  Scenario: A non-member should not see a notification
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the division page for "div2" of league "league1"
    When I follow "Create Team"
    And I fill in "team[name]" with "teamlame"
    And I press "Create Team"
    And I follow "Sign out"
    Given I am logged in as "email@email.com" with password "password"
    And I am on the division page for "div2" of league "league1"
    When I follow "Create Team"
    And I fill in "team[name]" with "teamcool"
    And I press "Create Team"
    Given I am on the division page for "div2" of league "league1"
    When I follow "teamlame vs. teamcool"
    And I follow "Edit"
    And I fill in "game[location]" with "haas pav"
    And I press "Save"
    And I follow "Sign out"
    Given I am logged in as "email3@email.com" with password "password"
    And I am on the home page
    When I follow "Notifications"
    Then I should not see "Schedule was changed" 
