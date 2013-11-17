Feature: create a division
 
  As an admin user
  I want to create a division in a league
  So that teams can sign up for divisions

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

Scenario: A non-admin should not be able to see create division button
  Given I am on the league page for "league1"
  Then I should not see "Create Division"
  Given I am logged in as "email2@email.com" with password "password"
  And I am on the league page for "league1"
  Then I should not see "Create Division"

Scenario: An admin should be able to create a division
  Given I am logged in as "email@email.com" with password "password"
  And I am on the league page for "league1"
  And I follow "Create Division"
  Then I should see "New Division"
  When I fill in "division[name]" with "somedivision"
  And I fill in "division[num_teams]" with "8"
  And I select "08 PM" from "division[start_time(4i)]"
  And I select "00" from "division[start_time(5i)]"
  And I select "10 PM" from "division[end_time(4i)]"
  And I select "00" from "division[end_time(5i)]"
  And I fill in "division[game_length]" with "60"
  And I fill in "division[num_locations]" with "2"
  And I fill in "division[num_teams]" with "8"
  And I press "Save"
  #Then I should be on the division page for "somedivision" of league "league1"
  Then I should see "Division was successfully created."

Scenario: An admin must fill in all fields in order to create the division
  Given I am logged in as "email@email.com" with password "password"
  And I am on the league page for "league1"
  And I follow "Create Division"
  And I press "Save"
  Then I should see "Name can't be blank"
  And I should see "Game length can't be blank"
  And I should see "Num teams can't be blank"
  And I should see "Num locations can't be blank"

Scenario: A divion end_time must occur after the start_time(4i)
  Given I am logged in as "email@email.com" with password "password"
  And I am on the league page for "league1"
  And I follow "Create Division"
  And I select "08 PM" from "division[start_time(4i)]"
  And I select "00" from "division[start_time(5i)]"
  And I select "07 PM" from "division[end_time(4i)]"
  And I select "00" from "division[end_time(5i)]"
  And I press "Save"
  Then I should see "must be before end time"

Scenario: An admin can update a division
  Given I am logged in as "email@email.com" with password "password"
  And I am on the division page for "testdiv" of league "league1"
  When I follow "Edit"
  And I fill in "division[name]" with "newdivisionname"
  And I press "Save"
  Then I should be on the division page for "newdivisionname" of league "league1"

@javascript
Scenario: Can delete a division record
  Given I am logged in as "email@email.com" with password "password"
  And I am on the division page for "testdiv" of league "league1"
  When I follow "Destroy"
  And I accept the alert
  Then I should be on the league page for "league1"
  And I should not see "testdiv"
