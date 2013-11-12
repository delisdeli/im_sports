Feature: create an account and authenticate
 
  As a user
  So that I can participate in Intramural sports
  I want to be able to register and login

  Background:
    Given the following users exist:
      | name       | email            | password  | password_confirmation  |
      | user_name  | email@email.com  | password  | password               |

Scenario: a user will not be created if password doesn't match password_confirmation
  Given I am on the signup page
  And I fill in "user[name]" with "myname"
  And I fill in "user[email]" with "email@berkeley.com"
  And I fill in "user[password]" with "password"
  And I fill in "user[password_confirmation]" with "wrongpassword"
  When I press "Save"
  Then I should see "doesn't match"

Scenario: a user will not be created if password doesn't match password_confirmation
  Given I am on the signup page
  And I fill in "user[name]" with "myname"
  And I fill in "user[email]" with "email@berkeley.com"
  And I fill in "user[password]" with "password"
  And I fill in "user[password_confirmation]" with "wrongpassword"
  When I press "Save"
  Then I should see "doesn't match"

Scenario: an existing user will not be logged in given the wrong password
  Given I am on the signin page
  And I fill in "session[email]" with "email@email.com"
  And I fill in "session[password]" with "wrongpassword"
  When I press "Sign in"
  Then I should see "Invalid"

Scenario: an existing user can log in
  Given I am on the signin page
  And I fill in "session[email]" with "email@email.com"
  And I fill in "session[password]" with "password"
  When I press "Sign in"
  Then I should see "Welcome"