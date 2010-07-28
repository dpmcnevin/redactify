@focus
Feature: Manage Spoilers
  In order to look at the timeline without spoilers
  As a user
  I want to see the redact tweets
  
  Scenario: Add a spoiler tag
    Given I am signed in
    When I go to the timeline page
    Then I should see "New version of Redactify is up" within "#tweet_19541735238"
    When I fill in "spoiler_name" with "Redactify"
    And I press "spoiler_submit"
    Then I should see "Tag Created for: Redactify"
    And I should see "REDACTED" within "#tweet_19541735238"
  
  @javascript
  Scenario: Show tweets that are redacted
    Given I am signed in
    And I have the spoiler tags
    | name      |
    | redactify |
    When I go to the timeline page
    And I follow "show" within "#tweet_19541735238"
    Then I should see "New version of Redactify is up" within "#tweet_19541735238"
  
  
  
  
  
  
