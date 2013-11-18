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
    | name    | num_teams  | start_time  | end_time  | num_locations  | game_length  | league_id  |
    | testdiv | 8          | 8pm         | 10pm      | 2              | 60           | 1          |

    Given the following teams exist:
    | captain_email      | name       | division_id |
    | email2@email.com   | testteam   | 1           |


  Scenario: An admin should be able to enter results of a game 
    Given I am logged in as "email1@email.com" with password "password" 
    And I am on the home page
    And I follow "league1"
    And I follow "testdiv"
    And I press "Edit Scores"
    When I fill in "testteam" with "1" and "testteam2" with "3"
    And I press "Enter"
    When I go to the home page 
    And I follow "league1"
    And I follow "testdiv"
    Then I should see "testteam 1 testteam2 3"

  Scenario: A non-admin should not be able to enter results of a game
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the home page
    And I follow "league1"
    And I follow "testdiv"
    Then I should not see "Edit Scores" 


 




