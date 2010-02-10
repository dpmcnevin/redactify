@focus
Feature: Add spoiler
  In order to not show tweets that are potential spoilers
  As a user
  I want add new spoilers

	Scenario: Add Spoilers
	  Given I am signed in
	  When I go to the homepage
		And I fill in "spoiler_name" with "Testing"
		And I press "Add Spoiler Tag"
		Then I should see "Testing" within "#user_tags"
	
	
	
	
	
	
	
	
