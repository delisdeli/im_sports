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
    | name    |
    | league1 |

    Given the following divisions exist:
    | name    | num_teams  | start_time  | end_time  | num_locations  | num_weeks | year | month | day | game_length  | league_id  |
    | testdiv | 8          | 8pm         | 10pm      | 2              | 2         | 2013 | 11    | 18  | 60           | 1          |

    Given the following teams exist:
    | captain_email      | name       | division_id | placeholder |
    | email2@email.com   | teamcool   | 1           | false       |
    | email3@email.com   | teamlame   | 1           | false       |

   
   Scenario: A team member should see a notification when schedule has been altered
     Given I am logged in as "email@email.com" with password "password"
     And user with email "email2@email.com" is a member of "teamcool"
     And I am on the home page   
     And I follow "league1"
     And I follow "testdiv"
     And I follow "teamcool vs. Placeholder Team 2"
     And I follow "Edit"
     And I fill in "game[location]" with "haas pav"
     And I press "Save"
     Given I am logged in as "email2@email.com" with password "password"
     When I follow "teamcool"
     Then I should see "Schedule was changed" 


   Scenario: A non-member should not see a notification
     Given I am logged in as "email@email.com" with password "password"
     And user with email "email2@email.com" is a member of "teamcool"
     And user with email "email3@email.com" is a member of "teamlame"
     And I am on the home page   
     And I follow "league1"
     And I follow "testdiv"
     And I follow "teamcool vs. Placeholder Team 2"
     And I follow "Edit"
     And I fill in "game[location]" with "haas pav"
     And I press "Save"
     And I follow "Sign out"
     Given I am logged in as "email3@email.com" with password "password"
     When I follow "teamlame"
     Then I should not see "Schedule was changed" 



