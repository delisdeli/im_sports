Feature: create a league
 
  As a league administrator
  I want to be able to create a league
  So that I can organize the sports for the season

  Background:
    Given the following users exist:
    | name       | email             | password  | password_confirmation  | admin  |
    | admin      | email@email.com   | password  | password               | true   |
    | user       | email2@email.com  | password  | password               | false  |

    Given the following leagues exist:
    | name    | sport      |
    | league5 | basketball |

Scenario: A non-admin should not be able to see create league button
  Given I am on the home page
  Then I should not see "Create League"
  Given I am logged in as "email2@email.com" with password "password"
  And I am on the home page
  Then I should not see "Create League"

Scenario: An admin should be able to create a league
  Given I am logged in as "email@email.com" with password "password"
  And I am on the homepage
  And I follow "Create League"
  Then I should see "New League"
  When I fill in "league[name]" with "league1"
  And I press "Create League"
  Then I should be on the league page for "league1"
  And I should see "league1"

Scenario: An admin can update a league
  Given I am logged in as "email@email.com" with password "password"
  And I am on the league page for "league5"
  When I follow "Edit"
  And I fill in "league[name]" with "league6"
  And I press "Create League"
  Then I should be on the league page for "league6"

@javascript
Scenario: Can delete a league record
  Given I am logged in as "email@email.com" with password "password"
  And I am on the leagues page
  Then I should see "league5"
  When I follow "Destroy"
  And I accept the alert
  Then I should be on the leagues page
  And I should not see "league5"
