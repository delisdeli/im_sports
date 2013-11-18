Feature: View the schedule of a division
  
  As a team member
  So that I know when to show up for a game
  I want to be able to view the schedule of my team's division

  Background:
    Given the following users exist:
    | name       | email             | password  | password_confirmation  | admin  |
    | admin      | email@email.com   | password  | password               | true   |
    | user       | email2@email.com  | password  | password               | false  |

    Given the following leagues exist:
    | name    |
    | league1 |

    Given the following divisions exist:
    | league_id | name     | start_time | end_time |
    | 1         | div1     | 8:00       | 10:00    |

    Given the following teams exist:
    | captain_email      | name     | division_id |
    | email2@email.com   | team10   | 1         |

  Scenario: A user should be able to view the schedule of his/her team's division
    Given I am logged in as "email2@email.com" with password "password"
    And I am on the home page
    And I follow "league1"
    And I follow "div1"
    Then I should see "team10"
