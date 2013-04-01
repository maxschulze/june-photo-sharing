Feature: Manage photos
  In order to manage photos like editing and deleting
  As an admin
  I want to be able to edit a photos attributes and delete them

  Background:
    Given I am signed in as an admin
			And 3 photos exist

  Scenario: Deleting a photo
	  When I go to the start page
	  	And I click on the first photo
    When I click on "Delete photo"
      And I press ok in the confirmation message
    Then the photo should be deleted
    
  Scenario: Editing when a photo was taken
    When I go to the start page
      And I click on the first photo
    Then I should see the edit form
    When I fill in a new date when the photo was taken
      And I click the "Save" button
    Then I should see when the photo was taken
    
  Scenario: Editing the title and description of a photo
    When I go to the start page
      And I click on the first photo
    Then I should see the edit form
    When I fill in a "title" for the photo
      And I fill in a "description" for the photo
      And I click the "Save" button
    Then I should see the photo "title"
    Then I should see the photo "description"