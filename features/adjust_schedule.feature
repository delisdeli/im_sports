Feature: Adjust the schedule of a division
  As a league administrator
  So that I can reschedule games if needed
  I want to be able to adjust the schedule of a division

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

Scenario: A non-admin should not be able to see adjust schedule button
  Given I am on the home page
  Then I should not see "Edit Division"
  Given I am logged in as "email2@email.com" with password "password"
  And I am on the home page
  Then I should not see "Edit Division"

Scenario: An admin should be able to edit a division
  Given I am logged in as "email@email.com" with password "password"
  And I am on the league page for "league1"
  And I follow "Edit Division"
  Then I should see "Edit Division"
  When I select "08 PM" from "division[start_time(4i)]"
  And I select "00" from "division[start_time(5i)]"
  And I select "10 PM" from "division[end_time(4i)]"
  And I select "00" from "division[end_time(5i)]"
  And I select "2013" from "division[start_date(1i)]"
  And I select "November" from "division[start_date(2i)]"
  And I select "18" from "division[start_date(3i)]"
  And I press "Save"
  #Then I should be on the division page for "somedivision" of league "league1"
  Then I should see "Division was successfully edited."

