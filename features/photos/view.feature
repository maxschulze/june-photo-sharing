Feature: View photos
  In order to look at cute photos of June
  As a user
  I want to be able to look at photos

  Background:
		Given I am signed in as a user
			And 3 photos exist
		
	Scenario: I want to be able to see an overview of all the photos
	  When I go to the start page
	  Then I should see an overview of photos
		
	Scenario: I want to see a detailed view of the photo
	  When I go to the start page
	  	And I click on the first photo
		Then I should see a larger version of the photo
	
	Scenario: I want to be able to go through the pictures page by page
	  Given I see 1 picture per page on the overview
	  When I go to the start page
		Then I should see the first photo
	  Then I should see the pagination
		When I select the second page
		Then I should see the second photo