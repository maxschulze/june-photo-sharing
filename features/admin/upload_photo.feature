Feature: Upload photos
  In order to upload new photos to the app
  As an admin
  I want to be able to upload photos with a simple uploader

  Background:
    Given I am signed in as an admin

  Scenario: Upload a new photo
    Given I am on the start page
    When I click on "Upload photo"
    Then I should see the upload photo form
    When I attach a valid photo file
      And I click the "Start upload" button
    Then I should see the uploads