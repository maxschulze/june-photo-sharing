Feature: Manage users
  In order to delete and edit people who have access
  As an admin
  I want to be able to manage the people who have access
  
  Background:
    Given I am signed in as an admin
      And I am on the manage people page
      And 3 people with access exist
  
  @wip
  @javascript
  Scenario: Edit a user
    When I click on edit for the first person
    Then I should be on the edit page
    When I change the first name
      And I click the "Update User" button
    Then I should be on the manage people page
      And I should see the new first name
      
  @javascript
  Scenario: Delete a user
    When I click on delete for the first person
      And I press ok in the confirmation message
    Then the person should be deleted