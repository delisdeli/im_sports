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
    | name    | sport      |
    | league1 | basketball |

    Given the following divisions exist:
    | name    | num_teams  | start_time  | end_time  | num_locations  | num_weeks | year | month | day | game_length  | league_id  |
    | testdiv | 8          | 8pm         | 10pm      | 2              | 8         | 2013 | 11    | 18  | 60           | 1          |

    Given I am logged in as "email2@email.com" with password "password"
    And I am on the division page for "testdiv" of league "league1"
    When I follow "Create Team"
    And I fill in "team[name]" with "teamlame"
    And I press "Create Team"

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
  And I fill in "division[num_weeks]" with "9"
  And I select "2013" from "division[start_date(1i)]"
  And I select "November" from "division[start_date(2i)]"
  And I select "18" from "division[start_date(3i)]"
  And I press "Save"
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
  And I should see "Num weeks can't be blank"

Scenario: A divion end_time must occur after the start_time(4i)
  Given I am logged in as "email@email.com" with password "password"
  And I am on the league page for "league1"
  And I follow "Create Division"
  And I select "08 PM" from "division[start_time(4i)]"
  And I select "00" from "division[start_time(5i)]"
  And I select "07 PM" from "division[end_time(4i)]"
  And I select "00" from "division[end_time(5i)]"
  And I press "Save"
  Then show me the page
  Then I should see "be before end time"

Scenario: An admin can add locations to a division
  Given I am logged in as "email@email.com" with password "password"
  And I am on the division page for "testdiv" of league "league1"
  When I fill in "new_location" with "Recreational Sports Facility"
  And I press "Add Location"
  Then I should be on the division page for "testdiv" of league "league1"
  And I should see "Recreational Sports Facility"
  And I should see "Location was successfully added."
  When I fill in "new_location" with "Recreational Sports Facility"
  And I press "Add Location"
  And I should see "Division already contains that location"

Scenario: A non-admin cannot add locations to a division
  Given I am logged in as "email2@email.com" with password "password"
  And I am on the division page for "testdiv" of league "league1"
  Then I should not see "Add New Location"

Scenario: A non-admin cannot delete locations
  Given I am logged in as "email@email.com" with password "password"
  And I am on the division page for "testdiv" of league "league1"
  When I fill in "new_location" with "Recreational Sports Facility"
  And I press "Add Location"
  When I follow "Sign out"
  Given I am on the division page for "testdiv" of league "league1"
  Then I should not see "Remove Recreational Sports Facility"

Scenario: An admin can delete locations
  Given I am logged in as "email@email.com" with password "password"
  And I am on the division page for "testdiv" of league "league1"
  When I fill in "new_location" with "Recreational Sports Facility"
  And I press "Add Location"
  When I press "Remove Recreational Sports Facility"
  Then I should be on the division page for "testdiv" of league "league1"
  And I should see "Location was successfully removed."

@javascript
Scenario: Can delete a division record
  Given I am on the profile page for "email2@email.com"
  Then I should see "teamlame"
  Given I am logged in as "email@email.com" with password "password"
  And I am on the division page for "testdiv" of league "league1"
  When I follow "Destroy Division"
  And I accept the alert
  Then I should be on the league page for "league1"
  And I should not see "testdiv"
  Given I am on the profile page for "email2@email.com"
  Then I should not see "teamlame"

Scenario: Bad league and division should give nice error message
  Given I am on the division page for id "10" of league id "1"
  Then I should see "That division doesn't exist"
  Given I am on the division page for id "1" of league id "20"
  Then I should see "That league doesn't exist" or "That division doesn't exist"

Scenario: Division that is too large should error 
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
  And I fill in "division[num_weeks]" with "5"
  And I select "2013" from "division[start_date(1i)]"
  And I select "November" from "division[start_date(2i)]"
  And I select "18" from "division[start_date(3i)]"
  And I press "Save"
  Then I should see "Not enough time to accomodate division schedule"

Scenario: Division with too few locations should error
  Given I am logged in as "email@email.com" with password "password"
  And I am on the league page for "league1"
  And I follow "Create Division"
  Then I should see "New Division"
  When I fill in "division[name]" with "somedivision"
  And I fill in "division[num_teams]" with "25"
  And I select "08 PM" from "division[start_time(4i)]"
  And I select "00" from "division[start_time(5i)]"
  And I select "10 PM" from "division[end_time(4i)]"
  And I select "00" from "division[end_time(5i)]"
  And I fill in "division[game_length]" with "60"
  And I fill in "division[num_locations]" with "1"
  And I fill in "division[num_teams]" with "8"
  And I fill in "division[num_weeks]" with "9"
  And I select "2013" from "division[start_date(1i)]"
  And I select "November" from "division[start_date(2i)]"
  And I select "18" from "division[start_date(3i)]"
  And I press "Save"
  Then I should see "Not enough locations to accomodate division schedule"
