Feature: Enter and adjust the results of games

  As a league administrator
  So that I can keep a record of how games within a division went
  I want to be able to enter and adjust the results of games

  Background:
    Given the following users exist:
    | name       | email             | password  | password_confirmation  | admin  |
    | admin      | email@email.com   | password  | password               | true   |
    | user       | email2@email.com  | password  | password               | false  |

    Given the following leagues exist:
    | name    |
    | league1 |

    Given the following divisions exist:
    | name    | num_teams  | start_time  | end_time  | num_locations  | num_weeks | year | month | day | game_length  | league_id  |
    | testdiv | 8          | 8pm         | 10pm      | 2              | 2         | 2013 | 11    | 18  | 60           | 1          |

    Given the following teams exist:
    | captain_email      | name       | division_id | placeholder |
    | email2@email.com   | testteam   | 1           |  false      |



  Scenario: An admin should be able to enter results of a game 
    Given I am logged in as "email@email.com" with password "password" 
    And I am on the home page
    And I follow "league1"
    And I follow "testdiv"
    And I follow "team1 vs. team2"
    And I follow "Edit"  
    When I fill in "game[score1]" with "1" 
    And I fill in "game[score2]" with "3"
    And I press "Save"
    When I go to the home page 
    And I follow "league1"
    And I follow "testdiv"
    Then I should see "team1 vs. team2"
    When I follow "team1 vs. team2"
    Then I should see "Score1: 1"
    And I should see "Score2: 3"



  Scenario: A non-admin should not be able to enter results of a game
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the home page
    And I follow "league1"
    And I follow "testdiv"
    And I follow "team1 vs. team2"
    And I follow "Edit"
    Then I should see "Must be admin user to access this feature" 


 




