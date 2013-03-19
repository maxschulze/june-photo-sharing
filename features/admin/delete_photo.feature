Feature: Delete photos
  In order to remove photos we might not want to show
  As an admin
  I want to be able to delete photos

  Background:
    Given I am signed in as an admin
			And 3 photos exist

  Scenario: Upload a new photo
	  When I go to the start page
	  	And I click on the first photo
    When I click on "Delete photo"
      And I press ok in the confirmation message
    Then the photo should be deleted