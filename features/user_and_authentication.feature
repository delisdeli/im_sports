Feature: create an account and authenticate
 
  As a user
  So that I can participate in Intramural sports
  I want to be able to register and login

  Background:
    Given the following users exist:
    | name       | email            | password  | password_confirmation  | admin |
    | user_name  | email@email.com  | password  | password               | false |
    | user       | email2@email.com | password  | password               | true  |
    | user2      | email3@email.com | password  | password               | false |

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

Scenario: Signed in user should see the correct user bar
  Given I am logged in as "email@email.com" with password "password"
  And I am on the home page
  Then I should see "user_name"
  And I should see "Sign out"
  And I should not see "Sign in"
  When I follow "user_name"
  Then I should be on the profile page for "email@email.com"
  Given I am on the home page
  And I follow "Sign out"
  Then I should be on the home page
  And I should not see "user_name"

Scenario: Non-signed in user should see the correct user bar
  Given I am on the home page
  Then I should not see "Sign out"
  When I follow "Sign in"
  Then I should be on the signin page
  Given I am on the home page
  When I follow "Register"
  Then I should be on the signup page

Scenario: Admin user can edit other users
  Given I am logged in as "email2@email.com" with password "password"
  And I am on the edit page for user "email3@email.com"
  Then I should see "Editing user"

Scenario: A non-admin user cannot edit other users
  Given I am logged in as "email3@email.com" with password "password"
  And I am on the edit page for user "email2@email.com"
  Then I should be on the home page
  And I should see "You are not authorized"

@javascript
Scenario: An admin can delete a user record
  Given I am logged in as "email2@email.com" with password "password"
  And I am on the users page
  Then I should see "email@email.com"
  When I follow "Destroy user_name"
  And I accept the alert
  Then I should be on the users page
  And I should not see "email@email.com"

Scenario: A non-admin cannot delete a user record
  Given I am logged in as "email3@email.com" with password "password"
  And I am on the users page
  Then I should be on the home page
  And I should see "Must be admin user"
