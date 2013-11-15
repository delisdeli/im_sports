Feature: create an account and authenticate
 
  As a user
  So that I can participate in Intramural sports
  I want to be able to register and login

  Background:
    Given the following users exist:
    | name       | email            | password  | password_confirmation  |
    | user_name  | email@email.com  | password  | password               |

Scenario: a user can be created
  Given I am on the signup page
  And I fill in "user[name]" with "myname"
  And I fill in "user[email]" with "email@berkeley.com"
  And I fill in "user[password]" with "password"
  And I fill in "user[password_confirmation]" with "password"
  When I press "Save"
  Then I should be on the profile page for "email@berkeley.com"

Scenario: a user will not be created if the email is already taken
  Given I am on the signup page
  And I fill in "user[name]" with "myname"
  And I fill in "user[email]" with "email@email.com"
  And I fill in "user[password]" with "password"
  And I fill in "user[password_confirmation]" with "password"
  When I press "Save"
  Then I should see "taken" 

Scenario: a user will not be created if password doesn't match password_confirmation
  Given I am on the signup page
  And I fill in "user[name]" with "myname"
  And I fill in "user[email]" with "email@berkeley.com"
  And I fill in "user[password]" with "password"
  And I fill in "user[password_confirmation]" with "wrongpassword"
  When I press "Save"
  Then I should see "doesn't match"

Scenario: a user will not be created if email is not in the correct form
  Given I am on the signup page
  And I fill in "user[email]" with "email@berkeleycom"
  When I press "Save"
  Then I should see "Email is invalid"
  And I fill in "user[email]" with "email@berkeleycom"
  When I press "Save"
  Then I should see "Email is invalid"
  And I fill in "user[email]" with "emailberkeleycom"
  When I press "Save"
  Then I should see "Email is invalid"

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

Scenario: an existing user can edit his information
  Given I am on the signin page
  And I fill in "session[email]" with "email@email.com"
  And I fill in "session[password]" with "password"
  When I press "Sign in"
  And I follow "Edit"
  And I fill in "user[name]" with "user_name2"
  And I fill in "Email" with "email2@email.com"
  And I fill in "Password" with "p1"
  And I fill in "Password confirmation" with "p1"

Scenario: we can change the name of an existing user
  Given I am on the profile page for "email@email.com"
  And I follow "Edit"
  And I fill in "user[name]" with "anothername"
  And I fill in "user[password]" with "password"
  And I fill in "user[password_confirmation]" with "password"
  When I press "Save"
  Then I should see "anothername"
