Feature: View timelines
  In order to look at the timeline
  As a user
  I want to see the timeline
  
  Scenario: See the timeline
    Given I am signed in
    When I go to the timeline page
    Then I should see "New version of Redactify is up" within ".tweet"
  
  
  

