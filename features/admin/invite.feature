Feature: Inviting new users
  In order to invite family members and other people to the photo sharing site
  As an admin
  I want want to be able to add and invite new users

  Scenario: As an admin I want to be able to invite a new user
    Given I am signed in as an admin
    When I go to the start page
      And I click on "people" in the main navigation
    Then I should be on the people overview page
    When I click on "Add person"
    Then I should see the invite form
    When I enter the information of the person that I want to invite
      And I click the "Send an invitation" button
    Then I should see the invitation success message
     And the person should have received an invitation email

  Scenario: As an invited person I want to be able to accept the invite
    Given I have received an invite
    When I click the invitation link in the email
    Then I should be on the registration page
      And I should be personally greeted
    When I pick and fill in a valid password
      And I click the "Set my password" button
    Then I should be on the start page
      And I should see "Your password was set successfully. You are now signed in."