Feature: Manage logins
  In order login via twitter
  As a user
  I want to login
  
  Scenario: Go to the homepage
    When I go to the homepage
    Then I should see "Login via Twitter"
    
    Scenario: Login via Twitter
      When I go to the homepage
      And I follow "Login via Twitter"
      When Twitter authorizes me
      Then I should see "@dpmcnevin"

    Scenario: Checking login status
      Given I am signed in
      When I go to the homepage
      Then I should see "@dpmcnevin"

    Scenario: Log out
      Given I am signed in
      When I go to the homepage
      And I follow "sign out"
      Then I should see "Login via Twitter"
  
  
  
  
  
  
